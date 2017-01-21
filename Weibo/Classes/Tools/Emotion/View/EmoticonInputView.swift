//
//  EmoticonInputView.swift
//  Weibo
//
//  Created by ityike on 2017/1/18.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class EmoticonInputView: UIView {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolbar: EmoticonToolbar!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 选中表情回调闭包属性
    fileprivate var selectedEmoticonCallBack: ((_ emoticon: Emoticon?) -> ())?
    
    
    class func inputView(selectedEmoticon: @escaping (_ emoticon: Emoticon?) -> ()) -> EmoticonInputView {
        let nib = UINib(nibName: "EmoticonInputView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! EmoticonInputView
        
        v.selectedEmoticonCallBack = selectedEmoticon
        
        return v
    }
    
    override func awakeFromNib() {
        collectionView.backgroundColor = UIColor.white
//        let nib = UINib(nibName: "EmoticonCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: cellId)
        // 设置工具栏代理
        toolbar.delegate = self
    }

}

extension EmoticonInputView: EmoticonToolbarDelegate {
    func emoticonToolbarDidSelectedItemIndex(toolbar: EmoticonToolbar, index: Int) {
        // 让collectionView发生滚动,每个分组的第0页
        let indexPath = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        // 设置按钮的选中状态
        toolbar.selectedIndex = index
    }
}

extension EmoticonInputView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 获取中心点
        var center = scrollView.center
        center.x += scrollView.contentOffset.x
        
        // 2. 获取当前显示的 cell 的 indexPath
        let paths = collectionView.indexPathsForVisibleItems
        // 3. 判断中心点在哪一个 indexPath 上，在哪一个页面上
        var targetIndexPath: IndexPath?
        for indexPath in paths {
            
            // 1> 根据 indexPath 获得 cell
            let cell = collectionView.cellForItem(at: indexPath)
            // 2> 判断中心点位置
            if cell?.frame.contains(center) == true {
                targetIndexPath = indexPath
                
                break
            }
        }
        guard let target = targetIndexPath else {
            return
        }
        
        // 4. 判断是否找到 目标的 indexPath
        // indexPath.section => 对应的就是分组
        toolbar.selectedIndex = target.section
        
        // 5. 设置分页控件
        // 总页数，不同的分组，页数不一样
        pageControl.numberOfPages = collectionView.numberOfItems(inSection: target.section)
        pageControl.currentPage = target.item
    }
}

extension EmoticonInputView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EmoticonManager.shared.packages.count
    }
    
    // 返回每个分组中表情页的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmoticonManager.shared.packages[section].numberOfPage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmoticonCell
        
        cell.emoticons = EmoticonManager.shared.packages[indexPath.section].emoticon(page: indexPath.item)
        
        cell.delegate = self
        
        return cell
    }
}


extension EmoticonInputView: EmoticonCellDelegate {
    func emoticonCellDidSelectedEmoticon(cell: EmoticonCell, em: Emoticon?) {
        
        // 执行闭包，选中的表情
        selectedEmoticonCallBack?(em)
        
        // 添加最近使用的表情
        guard let em = em else {
            return
        }
        // 最近分组，不刷新数据
        let indexPath = collectionView.indexPathsForVisibleItems[0]
        if indexPath.section == 0 {
            return
        }
        EmoticonManager.shared.recentEmoticon(em: em)
        // 刷新数据
        var indexSet = IndexSet()
        indexSet.insert(0)
        collectionView.reloadSections(indexSet)
    }
}

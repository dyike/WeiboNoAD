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
    
    @IBOutlet weak var toolbar: UIView!
    
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
    }
}

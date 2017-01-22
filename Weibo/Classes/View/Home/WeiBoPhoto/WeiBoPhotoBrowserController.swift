//
//  WeiBoPhotoBrowserController.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import SnapKit

private let WeiBoPhotoBrowserCell = "WeiBoPhotoBrowserCell"

class WeiBoPhotoBrowserController: UIViewController {
    
    var selectedIndex: Int
    var urls: [String]
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: WeiBoPhotoBrowserCollectionViewLayout())
    
    lazy var closeButton: UIButton = UIButton(title: "关闭", fontSize: 14, normalColor: UIColor.darkGray)
    lazy var saveButton: UIButton = UIButton(title: "保存", fontSize: 14, normalColor: UIColor.darkGray)
    
    
    init(selectedIndex: Int, urls: [String]) {
        self.selectedIndex = selectedIndex
        self.urls = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

private extension WeiBoPhotoBrowserController {
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        collectionView.frame = view.bounds
        closeButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        
        saveButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-20)
            make.bottom.equalTo(closeButton.snp.bottom)
            make.size.equalTo(closeButton.snp.size)
        }
        collectionView.register(WeiBoPhotoBrowserViewCell.self, forCellWithReuseIdentifier: WeiBoPhotoBrowserCell)
        collectionView.dataSource = self
        
        // 监听两个按钮点击
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
    }
}

extension WeiBoPhotoBrowserController {
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        print("保存")
    }
}


extension WeiBoPhotoBrowserController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeiBoPhotoBrowserCell, for: indexPath) as! WeiBoPhotoBrowserViewCell
        // 设置cell数据
        cell.picURL = urls[indexPath.item]
        
        return cell
    }
}


class WeiBoPhotoBrowserCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        // 设置itemSize
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        // 设置collectionView的属性
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}










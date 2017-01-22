//
//  WeiBoPhotoBrowserController.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit


class WeiBoPhotoBrowserController: UIViewController {
    
    var selectedIndex: Int
    var urls: [String]
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var closeButton: UIButton = UIButton()
    lazy var saveButton: UIButton = UIButton()
    
    
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
    
        
    }
}

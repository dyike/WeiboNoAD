//
//  EmoticonLayout.swift
//  Weibo
//
//  Created by ityike on 2017/1/19.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 表情集合视图布局
class EmoticonLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        itemSize = collectionView.bounds.size
        
        // 设定滚动方向
        scrollDirection = .horizontal
    }
}

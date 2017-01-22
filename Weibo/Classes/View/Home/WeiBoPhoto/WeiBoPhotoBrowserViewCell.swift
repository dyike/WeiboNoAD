//
//  WeiBoPhotoBrowserViewCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import SDWebImage

class WeiBoPhotoBrowserViewCell: UICollectionViewCell {
    var picURL: String? {
        didSet {
            guard let picURL = picURL,
                let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picURL) else {
                return
            }
            
            
            // 计算imageView的frame
            let x: CGFloat = 0
            let width = UIScreen.main.bounds.width
            let height = (width / image.size.width) * image.size.height
            
            var y: CGFloat = 0
            if height > UIScreen.main.bounds.height {
                y = 0
            } else {
                y = (UIScreen.main.bounds.height - height) * 0.5
            }
            imageView.frame = CGRect(x: x, y: y, width: width, height: height)
            
            // 设置图片
            imageView.image = image
            
        }
    }
    
    lazy var scrollView: UIScrollView = UIScrollView()
    
    lazy var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeiBoPhotoBrowserViewCell {
    func setupUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds

    }
}

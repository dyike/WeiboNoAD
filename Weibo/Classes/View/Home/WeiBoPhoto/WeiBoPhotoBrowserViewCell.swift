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
            setupContent(picURL: picURL)
        }
    }
    
    
    lazy var scrollView: UIScrollView = UIScrollView()
    
    lazy var imageView: UIImageView = UIImageView()
    
    lazy var progressView: WeiBoProgressView = WeiBoProgressView()
    
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
        contentView.addSubview(progressView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
        
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.clear
    }
}


extension WeiBoPhotoBrowserViewCell {
    
    func setupContent(picURL: String?) {
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
        //imageView.image = image
        progressView.isHidden = true
        let largeURL = getLargePicURL(picURL: picURL)
        imageView.sd_setImage(with: largeURL,
                              placeholderImage: image,
                              options: [],
                              progress: { (current, total) in
                                    self.progressView.progress = CGFloat(current) / CGFloat(total)
                                }, completed: { (_, _, _, _) in
                                    self.progressView.isHidden = true
                            })
        
        scrollView.contentSize = CGSize(width: 0, height: height)
    }
    
    
    func getLargePicURL(picURL: String) -> URL {
        let largeURL = picURL.replacingOccurrences(of: "/wap360/", with: "/large/")
        return URL(string: largeURL)!
    }
}

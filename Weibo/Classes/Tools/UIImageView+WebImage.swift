//
//  UIImageView+WebImage.swift
//  Weibo
//
//  Created by ityike on 2017/1/9.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    // 隔离SDWebimage 设置推行函数
    func setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false) {
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            // 设置占位图象
            image = placeholderImage
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self] (image, _, _, _) in
            // 完成回调
            // 判断是否是头像
            if isAvatar {
                self?.image = image?.avatarImage(size: self?.bounds.size)
            }
            
        }
    }
}

//
//  WeiBoStatusPicture.swift
//  Weibo
//
//  Created by ityike on 2017/1/10.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 微博配图
class WeiBoStatusPicture: NSObject {
    // 缩略图地址
    var thumbnail_pic: String? {
        didSet {
            // http://wx1.sinaimg.cn/thumbnail/b4af8cf1ly1fbyihnua1uj20c82cqgv4.jpg
            // http://wx1.sinaimg.cn/wap360/b4af8cf1ly1fbyihnua1uj20c82cqgv4.jpg
            // 更新连接
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    
    
    override var description: String {
        return yy_modelDescription()
    }
}

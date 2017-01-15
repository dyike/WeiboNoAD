//
//  WeiBoStatus.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
class WeiBoStatus: NSObject {
    // 微博ID
    var id: Int64 = 0
    // 微博内容
    var text: String?
    
    var user: WeiBoUser?
    // 转发数
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 点赞数
    var attitudes_count: Int = 0
    
    // 微博配图模型数组
    var pic_urls: [WeiBoStatusPicture]?
    
    // 被转发的原创微博
    var retweeted_status: WeiBoStatus?
    
    // 微博发布时间
    var created_at: String?
    // 微博来源
    var source: String? {
        didSet {
            // 重新计算来源，并保存
            source = "来自 " + ((source?.getHref()?.text) ?? "不显示的客户端")
        }
    }
    
    
    // 重写description的计算属性
    override var description: String {
        return yy_modelDescription()
    }
    
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": WeiBoStatusPicture.self]
    }
    
}

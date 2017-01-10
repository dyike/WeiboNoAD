//
//  WeiBoStatusModel.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation
import UIKit

// 单条微博的视图模型
/**
 如果没有任何父类，在开发时调试，输出调试信息，需要
 遵守CustomStringConvertible
 实现 description 计算属性
 */
class WeiBoStatusViewModel: CustomStringConvertible {
    
    // 微博模型
    var status: WeiBoStatus
    
    // 会员图标
    var memberIcon: UIImage?
    
    // 认证
    var vipIcon: UIImage?
    // 转发
    var retweetedStr: String?
    // 评论
    var commentStr: String?
    // 点赞
    var likeStr: String?
    
    
    // model:微博模型
    // return 微博视图模型
    init(model: WeiBoStatus) {
        self.status = model
        // 直接计算出会员图标/会员等级 0-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 0)"
            
            memberIcon = UIImage(named: imageName)
        }
        
        // 认证图标
        if (model.user?.verified) ?? false {
            vipIcon = UIImage(named: "avatar_vip")
        }
        // 设置底部计数字符串
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
    }
    
    // 评定转发，评论，点赞数
    private func countString(count: Int, defaultStr: String) -> String {
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万", Double(count / 10000))
    }
    
    var description: String {
        return status.description
    }
}

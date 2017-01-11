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
    // 配图大小
    var pictureViewSize = CGSize()
    
    // 如果是被转发的微博，原创微博一定没有图
    var picURLs: [WeiBoStatusPicture]? {
        // 如果有被转发的微博，返回被转发微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 都没有的话就返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    // 被转发的微博文字
    var retweetedText: String?
    
    
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
        // 没有认证
        
        switch model.user?.verified_type ?? -1 {
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        default:
            break
        }
        
        // 设置底部计数字符串
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        // 计算配图大小（有原创的就计算原创的，有转发的就计算转发的）
        pictureViewSize = calcPictureViewSize(count: picURLs?.count)
        
        // 设置被转发微博文字
        retweetedText = "@" + (status.retweeted_status?.user?.screen_name ?? "") + ": "
                        + (status.retweeted_status?.text ?? "")
    }
    
    // count: 配图数量
    private func calcPictureViewSize(count: Int?) -> CGSize {
        if count == 0 {
            return CGSize()
        }

        // 计算高度
        let row = (count! - 1) / 3 + 1
        var height = WeiBoStatusPictureViewOutterMargin
        height += CGFloat(row - 1) * WeiBoStatusPictureViewInnerMargin + CGFloat(row) * WeiBoStatusPictureItemWidth
        
        return CGSize(width: WeiBoStatusPictureViewWidth, height: height)
        
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

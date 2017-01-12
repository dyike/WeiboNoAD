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
    
    var rowHeight: CGFloat = 0
    
    
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
        
        // 计算行高
        updateRowHeight()
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
    // 根据当前的视图模型内容计算行高
    // 原创微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
    // 被转发微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12)+间距(12)+转发文本高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
    func updateRowHeight() {
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 35
        
        var height: CGFloat = 0
        let viewSize = CGSize(width: UIScreen.main.bounds.width - 2 * margin, height: CGFloat(MAXFLOAT))
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        // 顶部高度
        height = 2 * margin + iconHeight + margin
        // 正文
        if let text = status.text {
            height += (text as NSString).boundingRect(with: viewSize,
                                            options: [.usesLineFragmentOrigin],
                                            attributes: [NSFontAttributeName: originalFont],
                                            context: nil).height
        }
        // 判断是否转发
        if status.retweeted_status != nil {
            height += 2 * margin
            // 转发文本  使用retweetedText，拼接了 @用户名
            if let text = retweetedText {
                height += (text as NSString).boundingRect(with: viewSize,
                                                options: [.usesLineFragmentOrigin],
                                                attributes: [NSFontAttributeName: retweetedFont],
                                                context: nil).height
                
            }
        }
        // 配图视图
        height += pictureViewSize.height
        height += margin
        // 顶部
        height += toolbarHeight
        // 使用属性记录
        rowHeight = height
        
    }
    
    // 使用单个图象，更新配图的大小
    func updateSingalImageSize(image: UIImage) {
        var size = image.size
    
        // 过宽图象处理
        let maxWidth: CGFloat = 300
        let minWidth: CGFloat = 40
        if size.width > maxWidth {
            size.width = maxWidth
            // 等比例调整高度
            size.height = (image.size.height / image.size.width) * size.width
        }
        // 过窄图象处理
        if size.width < 300 {
            size.width = minWidth
            // 处理高度
            size.height = (image.size.height / image.size.width) * size.width / 3
        }
        
        
        // 尺寸需要增加顶部的12个点
        size.height += WeiBoStatusPictureViewOutterMargin
        // 更新设置配图的大小
        pictureViewSize = size
        // 更新行高
        updateRowHeight()
    }
}

//
//  WeiBoStatusCellTableViewCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoStatusCell: UITableViewCell {
    
    var viewModel: WeiBoStatusViewModel? {
        didSet {
            // 微博文本
            statusLabel?.text = viewModel?.status.text
            // 微博昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            // 设置会员等级 - 直接获取属性，不需要计算
            memberIconView.image = viewModel?.memberIcon
            // 认证
            vipIconView.image = viewModel?.vipIcon
            
            // 用户头像
            iconView.setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            
            // 底部
            toolBar.viewModel = viewModel
            
            // 微博配图高度
            pictureView.heightCons.constant = (viewModel?.pictureViewSize.height) ?? 0
            // 设置配图的url属性
//            if (viewModel?.status.pic_urls?.count)! > 4 {
//                // 修改数组 -> 将末尾的数据全部删除
//                var picUrls = viewModel!.status.pic_urls!
//                picUrls.removeSubrange((picUrls.startIndex + 4)..<picUrls.endIndex)
//                pictureView.urls = picUrls
//            } else {
//               pictureView.urls = viewModel?.status.pic_urls
//            }
            // （被转发和原创）
            pictureView.urls = viewModel?.picURLs
            //设置被转发微博的文字
            retweetedLabel?.text = viewModel?.retweetedText
        }
    }
    
    // 头像
    @IBOutlet weak var iconView: UIImageView!
    // 昵称
    @IBOutlet weak var nameLabel: UILabel!
    // 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    // 时间
    @IBOutlet weak var timeLabel: UILabel!
    // 来源
    @IBOutlet weak var sourceLabel: UILabel!
    // 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    // 微博内容
    @IBOutlet weak var statusLabel: UILabel!
    // 底部工具栏
    @IBOutlet weak var toolBar: WeiBoStatusToolBar!
    // 微博配图
    @IBOutlet weak var pictureView: WeiBoStatusPictureView!
    
    // 被转发微博的标签 -原创微博没有此控件
    @IBOutlet weak var retweetedLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

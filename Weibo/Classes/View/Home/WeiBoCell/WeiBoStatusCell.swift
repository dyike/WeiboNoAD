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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  WeiBoStatusCellTableViewCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 微博cell协议
@objc protocol WeiBoStatusCellDelegate: NSObjectProtocol {
    // 选中url字符串
    @objc func statusCellDidSelectedURLString(cell: WeiBoStatusCell, urlString: String)
}

// 微博cell
class WeiBoStatusCell: UITableViewCell {
    
    weak var delegate: WeiBoStatusCellDelegate?
    
    var viewModel: WeiBoStatusViewModel? {
        didSet {
            // 微博文本
            statusLabel?.attributedText = viewModel?.statusAttrText
            //设置被转发微博的文字
            retweetedLabel?.attributedText = viewModel?.retweetedAttrText
            
            
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
            // 配图视图模型
            pictureView.viewModel = viewModel
            
            // 微博配图高度
            // pictureView.heightCons.constant = (viewModel?.pictureViewSize.height) ?? 0
            
            // 设置来源
            sourceLabel.text = viewModel?.status.source
            // 发布时间
            timeLabel.text = (viewModel?.status.created_at?.dateByString())! as String

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
    @IBOutlet weak var statusLabel: FFLabel!
    // 底部工具栏
    @IBOutlet weak var toolBar: WeiBoStatusToolBar!
    // 微博配图
    @IBOutlet weak var pictureView: WeiBoStatusPictureView!
    
    // 被转发微博的标签 -原创微博没有此控件
    @IBOutlet weak var retweetedLabel: FFLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 离屏渲染 - 异步绘制 需要在GPU/CPU之间快速切换，耗电厉害
        //self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制后，会生成一张独立的图象，cell在屏幕上滚动的时候，本质上滚动的是这样图片
        // cell 优化要尽量减少图层的数量，相当于就只有一层
        // 停止滚动之后，可以接受监听
        self.layer.shouldRasterize = true
        // 使用 栅格化 必须要指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
        // 设置微博文本代理
        statusLabel.delegate = self
        retweetedLabel?.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension WeiBoStatusCell: FFLabelDelegate {
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        // 判断是否是url
        if !text.hasPrefix("http") {
            return
        }
        // 插入？表示如果代理没有实现协议方法，就什么都不做
        delegate?.statusCellDidSelectedURLString(cell: self, urlString: text)
    }
}


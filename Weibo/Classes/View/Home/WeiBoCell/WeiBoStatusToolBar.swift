//
//  WeiBoStatusToolBar.swift
//  Weibo
//
//  Created by ityike on 2017/1/9.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoStatusToolBar: UIView {
    var viewModel: WeiBoStatusViewModel? {
        didSet {
            retweetedButton.setTitle(viewModel?.retweetedStr, for: [])
            commentButton.setTitle(viewModel?.commentStr, for: [])
            likeButton.setTitle(viewModel?.likeStr, for: [])
            
        }
    }
    
    // 转发
    @IBOutlet weak var retweetedButton: UIButton!
    // 评论
    @IBOutlet weak var commentButton: UIButton!
    // 点赞
    @IBOutlet weak var likeButton: UIButton!
}

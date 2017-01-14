//
//  WeiBoComposeTypeButton.swift
//  Weibo
//
//  Created by ityike on 2017/1/14.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// UIControl 内置了touchUpInside事件
class WeiBoComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    
    // 使用图象，标题创建按钮，按钮布局从xib加载
    class func composeTypeButton(imageName: String, title: String) -> WeiBoComposeTypeButton {
        let nib = UINib(nibName: "WeiBoComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WeiBoComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        return btn
        
    }

}

//
//  UIButtonItem+Extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, title: String, fontSize: CGFloat = 16, target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // 实例化
        self.init(customView: btn)
    }
}

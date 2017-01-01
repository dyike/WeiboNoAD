//
//  UIButtonItem+Extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String, fontSize: CGFloat = 16, target: Any?, action: Selector, isBack: Bool = false) {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.1, height: 40))
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.setTitleColor(UIColor.orange, for: UIControlState.highlighted)
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
    
        // 是否是返回按钮
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // 实例化
        self.init(customView: btn)
    }
}

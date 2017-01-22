//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit


extension UIButton {
    
    // 便利构造函数通常在对系统类进行构造函数的扩充时使用
    // 特点：
    // 1. 便利构造函数通常都是写在extension里面
    // 2. 便利构造函数init前面需要加convenience 
    // 3. 在便利构造函数中需要明确调用self.init()
    
    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), for: UIControlState.highlighted)
        sizeToFit()
    }
    
    convenience init(title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor, backgroundImageName: String) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
        if backgroundImageName != "" {
           setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        }
        sizeToFit()
    }
    
    convenience init(title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor) {
        // 实例化
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
        sizeToFit()
    }
    
    convenience init(title: String, fontSize: CGFloat, normalColor: UIColor) {
        // 实例化
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = normalColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
}

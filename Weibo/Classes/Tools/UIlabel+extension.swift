//
//  UIlabel+extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/29.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String, fontSize: CGFloat, color: UIColor) {
        self.init()
        self.text = title
        self.textColor = color
        self.font = UIFont(name: "sytem", size: fontSize)
    }
}

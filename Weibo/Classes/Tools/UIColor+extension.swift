//
//  UIColor+extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/30.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff,
                  green:(hex >> 8) & 0xff,
                  blue:hex & 0xff)
    }
}

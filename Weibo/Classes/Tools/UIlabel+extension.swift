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
    
    // 改变行间距
//    func changeLineSpace(space:CGFloat) {
//        if self.text == nil || self.text == "" {
//            return
//        }
//        let text = self.text
//        let attributedString = NSMutableAttributedString.init(string: text!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = space
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: .init(location: 0, length: (text?.length())!))
//        self.attributedText = attributedString
//        self.sizeToFit()
//    }
    
}

//
//  ViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import YYModel

// 表情模型
class Emoticon: NSObject {
    
    // 表情类型，false - 图片表情， true - emoji
    var type = false
    
    // 表情字符串
    var chs: String?
    // 表情图片名称
    var png: String?
    // emoji 的十六进制编码
    var code: String? {
        didSet {
            guard let code = code else {
                return
            }
            let scanner = Scanner(string: code)
            var result: UInt32 = 0
            scanner.scanHexInt32(&result)
            emoji = String(Character(UnicodeScalar(result)!))
        }
    }
    var emoji: String?
    
    var times: Int = 0
    
    // 表情模型所在目录
    var directory: String?
    // 图片表情对应的图象
    var image: UIImage? {
        // 判断表情类型
        if type {
            return nil
        }
        
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
            let bundle = Bundle(path: path) else {
                return nil
        }
        
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    

    
    
    // 将当前的图象转换成图片的属性文本
    func imageText(font: UIFont) -> NSAttributedString {
        // 判断图象是否存在
        guard let image = image  else {
            return NSAttributedString(string: "")
        }
        // 创建文本附件
        let attachment = EmoticonAttachment()
        // 记录属性文本文字
        attachment.chs = chs
        
        attachment.image = image
        
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        // 返回图片属性文本
        let attrStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        // 设置字体属性
        attrStrM.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: 1))
        
        return attrStrM
    }
    
    
    override var description: String {
        return yy_modelDescription()
    }
    
}

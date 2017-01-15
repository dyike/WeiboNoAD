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
    var str: String?
    // 表情图片名称
    var png: String?
    // emoji 的十六进制编码
    var code: String?
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
            let path = Bundle.main.path(forResource: "HMEmoticon", ofType: nil),
            let bundle = Bundle(path: path) else {
            return nil
        }
        
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }

    
    override var description: String {
        return yy_modelDescription()
    }

}

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

    
    override var description: String {
        return yy_modelDescription()
    }

}

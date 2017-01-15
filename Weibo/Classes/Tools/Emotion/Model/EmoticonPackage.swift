//
//  EmoticonPackage.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import YYModel

// 表情包模型
class EmoticonPackage: NSObject {
    
    // 表情包分组名
    var groupName: String?
    // 表情包目录，从目录下加载info.plist可以创建表情模型数组
    var directory: String?
    
    // 懒加载表情模型的空数组
    // 使用懒加载可以避免后续的解包
    lazy var emoticons = [Emoticon]()
    
    override var description: String {
        return yy_modelDescription()
    }
}

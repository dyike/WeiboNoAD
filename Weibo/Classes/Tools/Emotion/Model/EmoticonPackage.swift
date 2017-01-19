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
    
    var bgImageName: String?
    
    // 表情包目录，从目录下加载info.plist可以创建表情模型数组
    var directory: String? {
        didSet {
            // 当前设置目录树，从目录下加载info.plist
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String: String]],
                let models = NSArray.yy_modelArray(with: Emoticon.self, json: array) as? [Emoticon] else {
                    return
            }
            
            // 遍历models数组 设置每一个表情符号的目录
            for m in models {
                m.directory = directory
            }
            
            // 设置表情模型数组
            emoticons += models
            
        }
    }
    
    // 懒加载表情模型的空数组
    // 使用懒加载可以避免后续的解包
    lazy var emoticons = [Emoticon]()
    
    var numberOfPage: Int {
        return (emoticons.count - 1) / 20 + 1
    }
    
    // 从懒加载的表情包中，按照Page截取最多20个表情模型数组
    func emoticon(page: Int) -> [Emoticon] {
        let count = 20
        let location = page * count
        var length = count
        // 判断数组是否越界
        if location + length > emoticons.count {
            length = emoticons.count - location
        }
        
        let range = NSRange(location: location, length: length)
        let subArray = (emoticons as NSArray).subarray(with: range)
        return subArray as! [Emoticon]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}

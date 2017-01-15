//
//  EmotionManager.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation


class EmoticonManager {
    // 单例
    static let shared = EmoticonManager()
    
    // 表情包的懒加载数组
    lazy var packages = [EmoticonPackage]()
    
    private init() {
        loadPackages()
    }
}

// MARK - 表情符号处理 查找表情图片
extension EmoticonManager {
    // 根据string在所有的表情符号中查找所有的表情模型对象
    func findEmoticon(string: String) -> Emoticon? {
        // 遍历表情包
        for p in packages {
            // 在表情数组中过滤string
            // 这是一个尾随闭包，还有一个最简单的写法
            // 闭包的格式定义可以省略，参数省略之后，，使用 $0, $1, $2...依次替代原有的参数
            // return也可以省略
            let result = p.emoticons.filter() { $0.chs == string }
//            let result = p.emoticons.filter( { (em) -> Bool in
//                return em.chs == string
//            })
            // 判断结果数组中的数量
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
    }
}

private extension EmoticonManager {
    func loadPackages() {
        // 读取emotions.plist
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String: String]],
            let models = NSArray.yy_modelArray(with: EmoticonPackage.self, json: array) as? [EmoticonPackage] else {
            return
        }
        
        // 设置表情包数据
        // 使用+=不会再次分配内存空间
        packages += models
    }
}

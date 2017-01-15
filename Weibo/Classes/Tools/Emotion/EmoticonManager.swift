//
//  EmotionManager.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation


class EmoticonManager {
    static let shared = EmoticonManager()
    
    // 表情包的懒加载数组
    lazy var packages = [EmoticonPackage]()
    
    private init() {
        loadPackages()
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

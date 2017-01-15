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
    
    private init() {
        loadPackages()
    }
}

private extension EmoticonManager {
    func loadPackages() {
        // 读取emotions.plist
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil) else {
            return
        }
        
        let array = NSArray(contentsOfFile: plistPath) as? [[String: String]]
        print(path)
    }
}

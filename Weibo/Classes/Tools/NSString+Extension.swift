//
//  NSString+Extension.swift
//  Weibo
//
//  Created by ityike on 2017/1/5.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

extension NSString {
    // 给当前文件追加文档路径
    func appendDocumentDir() -> String {
        let dir: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        return dir.appendingPathComponent(self.lastPathComponent)
    }
    
}

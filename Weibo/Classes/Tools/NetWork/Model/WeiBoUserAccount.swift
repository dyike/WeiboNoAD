//
//  WeiBoUserAccount.swift
//  Weibo
//
//  Created by ityike on 2017/1/4.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 用户账户信息
class WeiBoUserAccount: NSObject {
    // 访问令牌
    var access_token: String? //= "2.00BVldmBGjEGPB71caab9e85FZOTtC"
    // 用户id
    var uid: String?
    // access_token 的生命周期
    var expires_in: TimeInterval = 0.0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    // 过期日期
    var expiresDate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    // 1.偏好设置 2.沙盒-归档/plist/json 3.数据库（FMDB/CoreData） 4.钥匙串访问
    func saveAccount() {
        // 1 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        // 删除expires_in值
        dict.removeValue(forKey: "expires_in")
        // 2 字典序列化
        let filePath = ("useraccount.json" as NSString).appendDocumentDir()
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            else {
                return
        }
        // 3 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        print(filePath)
    }
}

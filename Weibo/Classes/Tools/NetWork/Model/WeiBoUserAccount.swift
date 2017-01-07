//
//  WeiBoUserAccount.swift
//  Weibo
//
//  Created by ityike on 2017/1/4.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

private let accountFile: NSString = "useraccount.json"

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
    
    // 用户昵称
    var screen_name: String?
    // 用户头像
    var avatar_large: String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
    override init() {
        super.init()
        // 从磁盘加载保存的文件
        let path = accountFile.appendDocumentDir()
        guard let data = NSData(contentsOfFile: path),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            return
        }
        // 使用字典设置属性
        yy_modelSet(with: dict ?? [:])
        
        // 处理token过期
        // expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
        // print(expiresDate)
        if expiresDate?.compare(Date()) != .orderedDescending {
            // print("账户过期")
            // 清空 token
            access_token = nil
            uid = nil
            // 删除账户文件
            _ = try? FileManager.default.removeItem(atPath: path)
        }
    }
    
    // 1.偏好设置 2.沙盒-归档/plist/json 3.数据库（FMDB/CoreData） 4.钥匙串访问
    func saveAccount() {
        // 1 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        // 删除expires_in值
        dict.removeValue(forKey: "expires_in")
        // 2 字典序列化
        let filePath = accountFile.appendDocumentDir()
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            else {
                return
        }
        // 3 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        print(filePath)
    }
}

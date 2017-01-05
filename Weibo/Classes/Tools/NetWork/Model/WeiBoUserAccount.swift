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
}

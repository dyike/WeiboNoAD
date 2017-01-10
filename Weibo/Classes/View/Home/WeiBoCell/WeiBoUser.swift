//
//  WeiBoUser.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import YYModel

// 微博用户模型
class WeiBoUser: NSObject {
    var id: Int64 = 0
    var screen_name: String?
    // 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    // 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified: Bool = false
    // 认证类型
    var verified_type: Int = -1
    
    // 会员等级 0-6
    var mbrank: Int = 0
    
    // 重写description的计算属性
    override var description: String {
        return yy_modelDescription()
    }
}

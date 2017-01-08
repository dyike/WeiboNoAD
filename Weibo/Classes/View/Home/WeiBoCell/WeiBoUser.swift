//
//  WeiBoUser.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 微博用户模型
class WeiBoUser: NSObject {
    var id: Int64 = 0
    var screen_name: String?
    var profile_image_url: String?
    var verifed_type: Int = 0
    var mbrank: Int = 0
    
    // 重写description的计算属性
    override var description: String {
        return yy_modelDescription()
    }
}

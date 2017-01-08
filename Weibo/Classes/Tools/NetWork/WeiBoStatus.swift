//
//  WeiBoStatus.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
class WeiBoStatus: NSObject {
    // 微博ID
    var id: Int64 = 0
    // 微博内容
    var text: String?
    
    var user: WeiBoUser?
    
    // 重写description的计算属性
    override var description: String {
        return yy_modelDescription()
    }
}

//
//  WeiBoStatusModel.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation
import UIKit

// 单条微博的视图模型
/**
 如果没有任何父类，在开发时调试，输出调试信息，需要
 遵守CustomStringConvertible
 实现 description 计算属性
 */
class WeiBoStatusViewModel: CustomStringConvertible {
    
    // 微博模型
    var status: WeiBoStatus
    
    // 会员图标
    var memberIcon: UIImage?
    
    // model:微博模型
    // return 微博视图模型
    init(model: WeiBoStatus) {
        self.status = model
        // 直接计算出会员图标/会员等级 0-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 0)"
            
            memberIcon = UIImage(named: imageName)
        }
    }
    
    var description: String {
        return status.description
    }
}

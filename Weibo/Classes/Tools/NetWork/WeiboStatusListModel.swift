//
//  WeiboStatusListModel.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

// 微博数据列表视图模型(微博数据处理)
// 父类的选择：
// 如果类使用“KVC”或者字典转模型框架设置对象值，类就需要继承自 NSObject
// 如果类知识包装一些代码逻辑，可以不使用任何父类，更加轻量
class WeiboStatusListModel {
    lazy var statusList = [WeiBoStatus]()
    
    func loadStatus(completion: @escaping (_ isSuccess: Bool) -> ()) {
        WeiBoNetWorkManager.shared.statusList { (list, isSuccess) in
            // 字典装模型
            guard let array = NSArray.yy_modelArray(with: WeiBoStatus.self, json: list ?? []) as? [WeiBoStatus] else {
                completion(isSuccess)
                return
            }
            // 拼接数据
            self.statusList += array
            
            // 完成回调
            completion(isSuccess)
            
        }
    }
}

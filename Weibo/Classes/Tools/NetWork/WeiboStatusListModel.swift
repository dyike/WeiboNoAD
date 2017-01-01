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
    
    func loadStatus(pullup: Bool, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        // since_id 下拉 取出数组中第一条微博
        let since_id = pullup ? 0 : (statusList.first?.id ?? 0)
        // max_id 上拉，取出数组的最后一条微博
        let max_id = !pullup ? 0 : (statusList.last?.id ?? 0)
        
        
        WeiBoNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 字典装模型
            guard let array = NSArray.yy_modelArray(with: WeiBoStatus.self, json: list ?? []) as? [WeiBoStatus] else {
                completion(isSuccess)
                return
            }
            // 拼接数据
            // 下拉刷新，应该将结果数组拼接在数组前面
            if pullup {
                // 上拉刷新结束后，将结果拼接在数组末尾
                self.statusList += array
            }
            // 下拉刷新，应该将结果数组拼接在数组前面
            self.statusList = array + self.statusList
            
            // 完成回调
            completion(isSuccess)
            
        }
    }
}

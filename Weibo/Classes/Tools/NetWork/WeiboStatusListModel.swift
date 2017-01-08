//
//  WeiboStatusListModel.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

// 上拉刷新最大尝试次数
private let maxPulluoTryTimes = 3

// 微博数据列表视图模型(微博数据处理)
// 父类的选择：
// 如果类使用“KVC”或者字典转模型框架设置对象值，类就需要继承自 NSObject
// 如果类知识包装一些代码逻辑，可以不使用任何父类，更加轻量
class WeiboStatusListModel {
    lazy var statusList = [WeiBoStatusViewModel]()
    // 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    func loadStatus(pullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        // 判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPulluoTryTimes {
            completion(true, false)
            return
        }
        
        // since_id 下拉 取出数组中第一条微博
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        // max_id 上拉，取出数组的最后一条微博
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        // 发起网络请求，加载微博数据
        WeiBoNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 0 判断网络请求是否成功
            if !isSuccess {
                // 直接回调返回
                completion(false, false)
                return
            }
            
            // 1 字典转模型
            // 定义结果可变数组
            var array = [WeiBoStatusViewModel]()
            // 遍历服务器返回的字典数组，字典组模型
            for dict in list ?? [] {
                // 创建微博模型,如果创建失败，继续后续的遍历
                guard let model = WeiBoStatus.yy_model(with: dict) else {
                    continue
                }
                // 将viewmodel添加到数组
                array.append(WeiBoStatusViewModel(model: model))
            }
        
            // 2 拼接数据
            // 下拉刷新，应该将结果数组拼接在数组前面
            if pullup {
                // 上拉刷新结束后，将结果拼接在数组末尾
                self.statusList += array
            }
            // 下拉刷新，应该将结果数组拼接在数组前面
            self.statusList = array + self.statusList
            // 3 判断上拉刷新的数据量
            if pullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess, false)
            } else {
                // 完成回调
                completion(isSuccess, true)
            }
            
            
        }
    }
}

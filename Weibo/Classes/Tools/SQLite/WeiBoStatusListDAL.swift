//
//  WeiBoStatusListDAL.swift
//  Weibo
//
//  Created by ityike on 2017/1/21.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

// DAL - data access layer 数据访问层
// 负责处理数据库和网络数据
class WeiBoStatusListDAL {
    
    class func loadStatus(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        guard let userId = WeiBoNetWorkManager.shared.userAccount.uid else {
            return
        }
        
        // 检查本地数据，如果有，直接返回
        let array = SQLiteManager.shared.loadStatus(userId: userId, since_id: since_id, max_id: max_id)
        if array.count > 0 {
            completion(array, true)
            return
        }
        
        // 加载网络数据
        WeiBoNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            if !isSuccess {
                completion(nil, false)
                return
            }
            guard let list = list else {
                completion(nil, isSuccess)
                return
            }
            
            // 加载完成之后，将网络数据(字典数组), 同步写入数据库
            SQLiteManager.shared.updateStatus(userId: userId, array: list)
            
            // 返回网络数据
            completion(list, isSuccess)

            
        }
        
    }
}

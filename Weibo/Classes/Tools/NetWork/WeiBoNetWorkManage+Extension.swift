//
//  WeiBoNetWorkManage+Extension.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

// MARK - 封装微博网络请求方法
extension WeiBoNetWorkManager {
    // since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    // max_id: 返回ID小于或等于max_id的微博，默认为0。
    // completion: 完成回调[list: 微博字典数组，isSuccess: 是否成功]
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        // Swift中Int可以转换成AnyObject，但是Int64不行
        let params = ["since_id": "\(since_id)",
            "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]     // 减1是为了上拉去重
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            // 从json中获取status字典数组
            let weiboInfo = json?["statuses"] as? [[String: AnyObject]]
            completion(weiboInfo, isSuccess)
        }
    }
}

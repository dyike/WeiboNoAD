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
    // completion: 完成回调[list: 微博字典数组，isSuccess: 是否成功]
    func statusList(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token": "2.00BVldmBGjEGPB41db88b702etzBAE"]
        
        tokenRequest(URLString: urlString, parameters: nil) { (json, isSuccess) in
            // 从json中获取status字典数组
            let weiboInfo = json?["statuses"] as? [[String: AnyObject]]
            completion(weiboInfo, isSuccess)
        }
    }
}

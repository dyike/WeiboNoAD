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
    
    // 未读数量  - 定时刷新
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        guard let uid = userAccount.uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid": uid]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
}


// MARK - OAuth相关方法
extension WeiBoNetWorkManager {
    // 加载accesstoken
    // code 授权码
    // completion 回调
    func loadAccessToken(code: String, completion: @escaping (_ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"

        let params = [
                "client_id": WeiBoAppKey,
                "client_secret": WeiBoAppSecret,
                "grant_type": "authorization_code",
                "code": code,
                "redirect_uri": WeiBoRedirectUri
            ]
        
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            // 直接使用字典设置UserAccount的属性
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            //print(self.userAccount)
        
            // 加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
                // 使用用户字典信息，用户昵称和用户头像
                self.yy_modelSet(with: dict)
                
                // 保存模型
                self.userAccount.saveAccount()
                
                // 完成回调
                completion(isSuccess)
            })
        }
    }
}


// MARK - 用户信息
extension WeiBoNetWorkManager {
    // 加载用户信息 - 用户加载后
    func loadUserInfo(completion: @escaping (_ dict: [String: AnyObject]) -> ()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid": uid]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            // 完成回调
            completion(json as? [String: AnyObject] ?? [:])
        }
        
    }
}

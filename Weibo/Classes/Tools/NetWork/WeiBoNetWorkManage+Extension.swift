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
    
    // 未读数量
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
    func loadAccessToken(code: String) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
//        client_id	申请应用时分配的AppKey。
//        client_secret	申请应用时分配的AppSecret。
//        grant_type 请求的类型，填写authorization_code
//        grant_type为authorization_code时
//        code	调用authorize获得的code值。
//        redirect_uri
        let params = [
                "client_id": WeiBoAppKey,
                "client_secret": WeiBoAppSecret,
                "grant_type": "authorization_code",
                "code": code,
                "redirect_uri": WeiBoRedirectUri
            ]
        
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            //print(json)
            // 直接使用字典设置UserAccount的属性
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            print(self.userAccount)
            // 保存模型
            self.userAccount.saveAccount()
        }
    }
}

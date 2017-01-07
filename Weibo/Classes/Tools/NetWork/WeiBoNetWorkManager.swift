//
//  WeiBoNetWorkManager.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import AFNetworking

// swift枚举支持任意类型
// switch / enum 在OC中支持整数
enum WeiBoHTTPMethod {
    case GET
    case POST
}
// 网络管理工具
class WeiBoNetWorkManager: AFHTTPSessionManager {
    // 实现一个单例
    // 静态区/常量 / 闭包
    // 第一次访问时，执行闭包，并且将结果存在shared
    static let shared: WeiBoNetWorkManager = {
        // 实例化
        let instance = WeiBoNetWorkManager()
        // 设置响应的反序列化的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        // 返回对象
        return instance
    }()
    
    lazy var userAccount = WeiBoUserAccount()
    
    // 用户登录标记(计算属性)
    var userLogin: Bool {
        return userAccount.access_token != nil
    }
    
    // 专门负责拼接， token 的网络请求方法
    func tokenRequest(method: WeiBoHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        //处理tocken字典
        // 0判断token是否为nil
        guard let token = userAccount.access_token else {
            //print("没有token！需要重新登陆")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoUserShouldLoginNotification), object: nil)
            
            completion(nil, false)
            return
        }
        // 1判断参数是否存在
        var parameters = parameters
        if parameters == nil {
            // 实例化字典
            parameters = [String: AnyObject]()
        }
        
        // 2 设置token字典
        parameters!["access_token"] = token as AnyObject?
        
        // 调用request发起真正的请求
        request(URLString: URLString, parameters: parameters!, completion: completion)
    }
    
    // 用一个函数封装get、post
    // 封装AFN 的get/post请求
    func request(method: WeiBoHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject], completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        // 成功回调
        let success = { (dataTask: URLSessionDataTask, json: Any) -> () in
            completion(json as AnyObject?, true)
        }
        // 失败回调
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> () in
            
            // 针对403处理用户token过期
            if (dataTask?.response as? HTTPURLResponse)?.statusCode == 403 {
                // print("token过期")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoUserShouldLoginNotification), object: "bad token")
            }
            print("网络请求错误 \(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    
    }
}

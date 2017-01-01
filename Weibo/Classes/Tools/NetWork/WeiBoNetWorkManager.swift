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
    static let shared = WeiBoNetWorkManager()
    
    // 访问令牌，所有的网络请求都基于此令牌（登录除外）
    // 访问令牌有时限（为了保护用户安全）
    var accessToken: String? = "2.00BVldmBGjEGPB41db88b702etzBAE"
    
    // 专门负责拼接， token 的网络请求方法
    func tokenRequest(method: WeiBoHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) {
        //处理tocken字典
        // 0判断token是否为nil
        guard let token = accessToken else {
            // FIXME: 发送通知，提示用户登陆
            
            print("没有token！需要重新登陆")
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
                print("token过期")
                // FIXME: 发送通知（本方法不知道被谁通知）
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

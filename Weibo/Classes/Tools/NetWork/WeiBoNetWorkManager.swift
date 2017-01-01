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
    
    // 用一个函数封装get、post
    // 封装AFN 的get/post请求
    func request(method: WeiBoHTTPMethod = .GET, URLString: String, parmaters: [String: Any], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        // 成功回调
        let success = { (dataTask: URLSessionDataTask, json: Any?) -> () in
            completion(json, true)
        }
        // 失败回调
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parmaters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parmaters, progress: nil, success: success, failure: failure)
        }
    
    }
}

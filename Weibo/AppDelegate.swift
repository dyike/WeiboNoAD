//
//  AppDelegate.swift
//  Weibo
//
//  Created by ityike on 2016/12/20.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WeiBoMainViewController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

    
    
}
// MARK: - 从服务器加载应用程序信息
extension AppDelegate {
    
    
    func loadAppInfo() {
        // 模拟异步
        DispatchQueue.global().async {
            // 1  url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            // 2 data
            let data = NSData(contentsOf: url!)
            // 3 写入磁盘
            // 沙盒目录
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            // 直接保存在沙盒，等待下一次程序启动使用
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕\(jsonPath)")
        }
        
    }
}

 

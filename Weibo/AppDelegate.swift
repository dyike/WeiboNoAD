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
        return true
    }



}


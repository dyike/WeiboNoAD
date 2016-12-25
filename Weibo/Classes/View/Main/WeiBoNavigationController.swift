//
//  WeiBoNavigationController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoNavigationController: UINavigationController {
    
    // 重写push 方法，所有的push动作都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏tabbar
        // 如果不是栈地的控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }

}

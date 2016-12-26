//
//  WeiBoNavigationController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    // 重写push 方法，所有的push动作都会调用此方法
    // viewController 是被push的控制器，设置他左边的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏tabbar
        // 如果不是栈地的控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        // 判断控制器的类型
        if let vc = viewController as? WeiBoBaseViewController {
            var title = "返回"
            // 判断控制器的级数，如果控制器只有一个子控制器，显示栈底控制器的标题
            if childViewControllers.count == 1 {
                // title 显示首页的标题
                title = childViewControllers.first?.title ?? "返回"
            }
            // 取出 navItem
            vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(backToParent), isBack: true)
            
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    // 返回到上一层控制器
    @objc private func backToParent() {
        popViewController(animated: true)
    }

}

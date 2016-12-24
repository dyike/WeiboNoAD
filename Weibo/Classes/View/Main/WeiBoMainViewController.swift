//
//  WeiBoMainViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        
    }


}
// extension 类似于oc中分类，在swift中还可以用来切分代码块
// 可以将相近功能的函数，放在一个extension 
// 设置界面：
extension WeiBoMainViewController {
    
    // 设置所有子控制器
    func setupChildControllers() {
        let array = [
            ["className": "WeiBoHomeViewController", "title": "首页", "imageName": "home"],
            ["className": "WeiBoMessageViewController", "title": "消息", "imageName": "message"],
            ["className": "WeiBoDiscoverViewController", "title": "发现", "imageName": "discover"],
            ["className": "WeiBoProfileViewController", "title": "我", "imageName": "profile"]
        ]
        
        var arrayWeibo = [UIViewController]()
        for dict in array {
            arrayWeibo.append(createController(dict: dict))
        }
        viewControllers = arrayWeibo
    }
    
    // 使用字典创建一个子控制器
    // [className, title, imageName]
    private func createController(dict: [String: String]) -> UIViewController {
        // 1 取得字典内容
        guard let className = dict["className"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let classView = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type else {
            return UIViewController()
        }
        // 2 创建视图控制器
        // 将className转换成class
        //let viewController = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type
        let viewController = classView.init()
        viewController.title = title
        
        // 3 设置图象
        viewController.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        let navigation = WeiBoNavigationController(rootViewController: viewController)
        return navigation
    }
}

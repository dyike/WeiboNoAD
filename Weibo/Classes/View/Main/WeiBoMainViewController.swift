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
        setupComposeButton()
        
    }
    // MARK: - 监听方法
    // 撰写微博
    // private 能够保证方法私有，仅当前对象能访问
    // @objc 允许这个函数在运行时通过OC的消息机制被调用
    @objc func composeStatus() {
        print("xie weibo")
    }
    
    // MARK： -私有控件
    // 发布微博按钮
    lazy var composeButton = UIButton.init(imageName: "tabbar_add", backgroundImageName: "tabbar_compose_button")

}
// extension 类似于oc中分类，在swift中还可以用来切分代码块
// 可以将相近功能的函数，放在一个extension 
// 设置界面：
extension WeiBoMainViewController {
    
    // 发布微博按钮
    func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 设置按钮的位置（计算）
        let count = CGFloat(childViewControllers.count)
        
        // 将向内缩进的宽度减少，能够让按钮的宽度变大。
        let width = tabBar.bounds.width / count - 1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        
        // 按钮的监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置所有子控制器
    func setupChildControllers() {
        let tabBarContent = [
            ["className": "WeiBoHomeViewController", "title": "首页", "imageName": "home"],
            ["className": "WeiBoMessageViewController", "title": "消息", "imageName": "message"],
            ["className": "UIViewController"],
            ["className": "WeiBoProfileViewController", "title": "我", "imageName": "profile"],
            ["className": "WeiBoDiscoverViewController", "title": "发现", "imageName": "discover"]
        ]
        
        var arrayWeibo = [UIViewController]()
        for dict in tabBarContent {
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
        
        
        // 4 设置tabbar 的标题字体
        viewController.tabBarItem.setBadgeTextAttributes([NSForegroundColorAttributeName: UIColor(red: 0.05, green: 0.38, blue: 0.56, alpha: 0.5)], for: .highlighted)
        viewController.tabBarItem.setBadgeTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        let navigation = WeiBoNavigationController(rootViewController: viewController)
        return navigation
    }
}

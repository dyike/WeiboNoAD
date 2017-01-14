//
//  WeiBoMainViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit
import SVProgressHUD

class WeiBoMainViewController: UITabBarController {
    // 定时器
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposeButton()
        
        setupNewFeatureViews()
        
        setupTimer()
        // 设置代理
        delegate = self
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WeiBoUserShouldLoginNotification), object: nil)
        
    }
    
    deinit {
        // 销毁时钟
        timer?.invalidate()
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /* 切换屏幕横竖屏
        landscape : 横屏
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait   // 竖屏
    }
    
    // MARK: 监听方法
    @objc func userLogin(n: Notification) {
        print("用户登录通知\(n)")
        
        var deadline = DispatchTime.now()
        
        // 判断n.object是否有值，如果有值，提示用户重新登录
        if n.object != nil {
            // 设置指示器渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需要重新登录")
            // 修改延迟时间
            deadline = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            SVProgressHUD.setDefaultMaskType(.clear)
            // 展现登陆控制器 - 通常会和 UINavigationController 连用，方便发挥
            let nav = UINavigationController(rootViewController: WeiBoOAuthViewController())
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
   
    // MARK: - 监听方法
    // 撰写微博
    // private 能够保证方法私有，仅当前对象能访问
    // @objc 允许这个函数在运行时通过OC的消息机制被调用
    @objc func composeStatus() {
        // 测试方向旋转
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.red
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true, completion: nil)
        
        // FIXME
        // 0 判断是否登陆
        // 1 实例化视图 
        let v = WeiBoComposeTypeView.composeTypeView()
        // 2 显示视图  - 主要闭包的循环引用 [weak v]
        v.show { [weak v] (className) in
            // 展现撰写微博控制器
            guard let className = className,
                let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type else {
                    v?.removeFromSuperview()
                return
            }
            let vc = cls.init()
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true) {
                v?.removeFromSuperview()
            }
        }
        
    }
    
    // MARK： -私有控件
    // 发布微博按钮
    lazy var composeButton = UIButton.init(imageName: "tabbar_add", backgroundImageName: "tabbar_compose_button")

}

extension WeiBoMainViewController: UITabBarControllerDelegate {
    // 将要选择 TabBarItem
    // tabBarController: tabBarController
    // viewController: 目标控制器
    // returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        // 获取控制器在数组中的索引
        let index = (childViewControllers as NSArray).index(of: viewController)
        // 获取当前索引
        // 判断当前索引是首页，同时index也是首页，重复点击首页按钮
        if selectedIndex == 0 && index == selectedIndex {
            // 让表格滚动到顶部
            // 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WeiBoHomeViewController
            // 滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            // 刷新数据 - 增加延迟，是保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
            // 清除tabbarItem的badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0

        }
        
        // 判断目标控制器是否是UIViewController
        return !viewController.isMember(of: UIViewController.self)
        
    }
}

// MARK - 时钟相关方法
extension WeiBoMainViewController {
    func setupTimer() {
        // 时间间隔60秒
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // 时钟触发方法
    @objc func updateTimer() {
        if !WeiBoNetWorkManager.shared.userLogin {
            return
        }
        WeiBoNetWorkManager.shared.unreadCount { (count) in
            // 设置 tabBarItem 的 badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            // 设置app的badgeNumber
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

// MARK 新特性视图处理
extension WeiBoMainViewController {
    func setupNewFeatureViews() {
        // 0 判断是否登陆
        if !WeiBoNetWorkManager.shared.userLogin {
            return
        }
        // 1 检查版本是否更新
        // 如果更新，显示新特性，否则显示欢迎
        let v = isNewVersion ? WeiBoNewFeatureView.newFeatureView() : WeiBoWelcomeView.welcomeView()
        // 2 添加视图
        
        view.addSubview(v)
    }
    
    // extension中可以有计算属性，不会占用存储空间
    private var isNewVersion: Bool {
        // 1 取当前的版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//        print(currentVersion)
        // 2 取保存在“Document”目录中的之前的版本
        let path = ("version" as NSString).appendDocumentDir()
        let sandboxVersion = try? String(contentsOfFile: path) 
//        print(sandboxVersion)
//        print(path)
        // 3 将当前版本保存在沙盒中
        _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        // 4 返回两个版本号是否一致
        
        return currentVersion != sandboxVersion
    }
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
        let width = tabBar.bounds.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        
        // 按钮的监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置所有子控制器
    func setupChildControllers() {
        
        // 获取沙河json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        // 加载 data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断data 是否存在，如果没有，说明本地沙盒没有文件
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        //  - data一定有一个内容
        
        // 反序列化
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: Any]] else {
            return
        }
        
        // 循环数组，循环创建控制器数组
        var arrayWeibo = [UIViewController]()
        for dict in array! {
            arrayWeibo.append(createController(dict: dict))
        }
        // 设置 tabBar 的子控制器
        viewControllers = arrayWeibo
    }
    
    // 使用字典创建一个子控制器
    // [className, title, imageName]
    private func createController(dict: [String: Any]) -> UIViewController {
        // 1 取得字典内容
        guard let className = dict["className"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let classView = NSClassFromString(Bundle.main.nameSpace + "." + className) as? WeiBoBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String] else {
            return UIViewController()
        }
        // 2 创建视图控制器
        // 将className转换成class
        //let viewController = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type
        let viewController = classView.init()
        viewController.title = title
        
        // 设置控制器的访客字典信息
        viewController.visitorInfoDictionary = visitorDict
        
        // 3 设置图象
        viewController.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        viewController.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        
        // 4 设置tabbar 的标题字体
        viewController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        viewController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        let navigation = WeiBoNavigationController(rootViewController: viewController)
        return navigation
    }
}

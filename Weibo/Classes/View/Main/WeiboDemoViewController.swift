//
//  WeiboDemoViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiboDemoViewController: WeiBoBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置标题
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    @objc func showNext() {
        let vc = WeiboDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// 设置界面
extension WeiboDemoViewController {
    
    // 重写父类方法
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
    }
    

}

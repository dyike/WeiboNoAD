//
//  WeiBoHomeViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoHomeViewController: WeiBoBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func showFriends() {
        let vc = WeiboDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

// 设置界面
extension WeiBoHomeViewController {
    override func setupUI() {
        super.setupUI()
        
        // 设置导航栏按钮
        // 无法高亮
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", fontSize: 16, target: self, action: #selector(showFriends), isBack: true)
        
        
    }
}

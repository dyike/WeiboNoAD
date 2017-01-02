//
//  WeiBoOAuthViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/2.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
// 通过WebView加载新浪微博授权页面控制器
class WeiBoOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        
        // 设置导航栏
        title = "登录渣浪微博"
        // 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

}

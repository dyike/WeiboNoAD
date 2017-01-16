//
//  WeiBoWebViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 网页控制器
class WeiBoWebViewController: WeiBoBaseViewController {

    fileprivate lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    
    var urlString: String? {
        didSet {
            
            guard let urlString = urlString,
                let url = URL(string: urlString) else {
                    return
            }
            webView.loadRequest(URLRequest(url: url))
        }
    }

}

extension WeiBoWebViewController {
    override func setupTableView() {
        // 设置标题
        navItem.title = "网页"
        
        // 设置webview
        view.insertSubview(webView, belowSubview: navigationBar)
        webView.backgroundColor = UIColor.white
        // 修复底部的黑条，在底部有透明控件的时候
        webView.isOpaque = false
        
        // 设置contentInset
        webView.scrollView.contentInset.top = navigationBar.bounds.height
    }
}

//
//  WeiBoOAuthViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/2.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import SVProgressHUD


// 通过WebView加载新浪微博授权页面控制器
class WeiBoOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        // 取消滚动视图
        webView.scrollView.isScrollEnabled = false
        // 设置代理
        webView.delegate = self
        // 设置导航栏
        title = "登录渣浪微博"
        // 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动登录", fontSize: 16, target: self, action: #selector(autoFill), isBack: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WeiBoAppKey)&redirect_uri=\(WeiBoRedirectUri)"
        // 确定要访问的资源
        guard let url = URL(string: urlString) else {
            return
        }

        // 建立请求
        let request = URLRequest(url: url)
        // 加载请求
        webView.loadRequest(request)
        
    }
    
    // 关闭控制器
    @objc func close() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func autoFill() {
//        // 准备js
//        let js = "document.getElementById('userId').value = '********';" + "document.getElementById('passwd').value = '********‘;"
//        // 让webview执行js
//        webView.stringByEvaluatingJavaScript(from: js)
//    }

}


extension WeiBoOAuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 如果请求地址包含 https://www.baidu.com/ 不加载页面，否则加载页面
        // request.url?.absoluteString.hasPrefix(WeiBoRedirectUri) 返回值是true/false/nil
        if request.url?.absoluteString.hasPrefix(WeiBoRedirectUri) == false {
            return true
        }
        
//        print("加载请求----\(request.url?.absoluteString)")
//        print("加载请求-----\(request.url?.query)")
        // 从 https://www.baidu.com/ 回调地址中，查找字符串code，如果有，就授权成功
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            return false
        }
        // 从query中取出授权码
        let code = request.url?.query?.substring(from: "code=".endIndex)
        //print("获取授权码\(code)")
        
        // 使用授权码获取acess_token
        WeiBoNetWorkManager.shared.loadAccessToken(code: code!)
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

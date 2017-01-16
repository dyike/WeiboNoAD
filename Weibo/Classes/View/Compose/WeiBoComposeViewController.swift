//
//  WeiBoComposeViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/14.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 撰写微博视图控制器
class WeiBoComposeViewController: UIViewController {
    
    // 文本编辑视图
    @IBOutlet weak var textView: UITextView!
    //底部工具
    @IBOutlet weak var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var sendButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("发布", for: [])
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        // 设置标题颜色
        btn.setTitleColor(UIColor.white, for: [])
        btn.setTitleColor(UIColor.gray, for: .disabled)
        
        // 设置背景图片
        btn.setBackgroundImage(UIImage(named: "common_button_orange"), for: [])
        btn.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        
        // 设置大小
        btn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
        return btn
    }()

}

private extension WeiBoComposeViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        setupNavigationBar()
    }
    
    // 设置导航栏
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        sendButton.isEnabled = false
    }
}

//
//  WeiBoComposeViewController.swift
//  Weibo
//
//  Created by ityike on 2017/1/14.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import SVProgressHUD

// 撰写微博视图控制器
class WeiBoComposeViewController: UIViewController {
    
    // 文本编辑视图
    @IBOutlet weak var textView: WeiBoComposeTextView!
    //底部工具
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var titileLabel: UILabel!
    
    // 表情输入视图
    lazy var emoticonView: EmoticonInputView = EmoticonInputView.inputView { [weak self] (emoticon) in
        self?.textView.insertEmoticon(em: emoticon)
    }
    
    // 工具栏底部约束
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 激活键盘
        textView.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 关闭键盘
        textView.resignFirstResponder()
    }
    
    @objc func keyboardChanged(n: Notification) {
        guard let rect = (n.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            else {
                return
        }
        
        let offset = view.bounds.height - rect.origin.y
        toolbarBottomCons.constant = offset
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postStatus() {
        
        // 获取发送到服务器的表情图片文字字符串
        let text = textView.emoticonText
        
        let image: UIImage? = nil //UIImage(named: "avatar_default_big")
        WeiBoNetWorkManager.shared.postStatus(statusText: text, image: image) { (result, isSuccess) in
            SVProgressHUD.setDefaultStyle(.dark)
            
            let message = isSuccess ? "发送成功" : "网络错误"
            
            SVProgressHUD.showInfo(withStatus: message)
            // 成功 关闭当前窗口
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    SVProgressHUD.setDefaultStyle(.light)
                    self.close()
                })
            }
        }
    }
    
    // 切换表情键盘
    @objc func emoticonKeyboard() {
        
        textView.inputView = (textView.inputView == nil) ? emoticonView : nil
        
        textView.reloadInputViews()
    }
    
}


extension WeiBoComposeViewController: UITextViewDelegate {
    
    /// 文本视图文字变化
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
    }
}


private extension WeiBoComposeViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        setupNavigationBar()
        setupToolbar()
    }
    
    func setupToolbar() {
        
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        var items = [UIBarButtonItem]()
        // 在头部增加一个弹簧
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        for item in itemSettings {
            let btn = UIButton()
            guard let imageName = item["imageName"] else {
                continue
            }
            let image = UIImage(named: imageName)
            let imageHighLighted = UIImage(named: imageName + "_highlighted")
            
            btn.setImage(image, for: [])
            btn.setImage(imageHighLighted, for: .highlighted)
            
            btn.sizeToFit()
            
            let imageSelected = UIImage(named: "half_compose_icon_keyboard")
            let imageSelectedHL = UIImage(named: "half_compose_icon_keyboard_highlighted")
            if btn.isSelected {
                btn.setImage(imageSelected, for: [])
                btn.setImage(imageSelectedHL, for: .highlighted)
            }
            
            if let actionName = item["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            
            items.append(UIBarButtonItem(customView: btn))
            
            // 追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        
        toolBar.items = items
        
    }
    
    // 设置导航栏
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        navigationItem.titleView = titileLabel
        sendButton.isEnabled = false
        
    }
}

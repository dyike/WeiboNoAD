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
    @IBOutlet weak var textView: UITextView!
    //底部工具
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var titileLabel: UILabel!
    
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
        
        guard let text = textView.text else {
            return
        }
        
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
        let emoticonKeyboardView = EmoticonInputView.inputView { [weak self] (emoticon) in
            self?.insertEmoticon(em: emoticon)
        }
    
        textView.inputView = (textView.inputView == nil) ? emoticonKeyboardView : nil
        
        textView.reloadInputViews()
    }
    
    func insertEmoticon(em: Emoticon?) {
        // em == nil 是删除按钮
        guard let em = em else {
            // 删除文本
            textView.deleteBackward()
            return
        }
        
        if let emoji = em.emoji, let textRange = textView.selectedTextRange {
        
            textView.replace(textRange, withText: emoji)
            return
        }
        
        let imageText = em.imageText(font: textView.font!)
        // 获取当前textView属性文本
        let attrStrM = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharacters(in: textView.selectedRange, with: imageText)
        
        let range = textView.selectedRange
    
        // 设置文本
        textView.attributedText = attrStrM
        // 恢复光标的位置
        textView.selectedRange = NSRange(location: range.location + 1, length: range.length)
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

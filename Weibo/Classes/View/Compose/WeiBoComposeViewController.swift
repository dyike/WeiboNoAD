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
    
    @IBOutlet weak var picPickerView: WeiBoPicPickerCollectionView!
    
    // 高度约束
    @IBOutlet weak var picPickerViewHeightCons: NSLayoutConstraint!
    
    // 表情输入视图
    lazy var emoticonView: EmoticonInputView = EmoticonInputView.inputView { [weak self] (emoticon) in
        self?.textView.insertEmoticon(em: emoticon)
    }
    
    lazy var images: [UIImage] = [UIImage]()
    
    // 工具栏底部约束
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupNotifications()
        
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    @objc func picPicker() {
        // 退出键盘
        textView.resignFirstResponder()
        
        picPickerViewHeightCons.constant = UIScreen.main.bounds.height * 0.7
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func addPhoto() {
        // 判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        // 创建照片选择控制器
        let ipc = UIImagePickerController()
        // 设置照片源
        ipc.sourceType = .photoLibrary
        // 设置代理
        ipc.delegate = self
        
        present(ipc, animated: true, completion: nil)
    }
    
}

// MARK - UIImagePickerController的代理方法
extension WeiBoComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 获取选中的照片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        images.append(image)
        
        // 展示照片
        picPickerView.images = images
        
        // 退出选择控制器
        picker.dismiss(animated: true, completion: nil)
        
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
        
        let itemSettings = [["imageName": "compose_toolbar_picture", "actionName": "picPicker"],
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
    
    // 设置监听通知
    func setupNotifications() {
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        // 监听添加图片的通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPhoto),
                                               name: NSNotification.Name(rawValue: WeiBoPicPickerAddPhoto),
                                               object: nil)
        
    }
}

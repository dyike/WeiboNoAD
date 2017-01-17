//
//  WeiBoComposeTextView.swift
//  Weibo
//
//  Created by ityike on 2017/1/17.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoComposeTextView: UITextView {
    
    fileprivate lazy var placeholderLabel = UILabel()
    
    
    override func awakeFromNib() {
        setupUI()
    }
    
    // 注销通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func textChanged(n: Notification) {
        placeholderLabel.isHidden = self.hasText
    }

}

private extension WeiBoComposeTextView {
    
    func setupUI() {
        
        // 注册通知，通知是一对多
        // 如果其他控件监听当前文本视图的通知，不会影响
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLabel.sizeToFit()
        
        addSubview(placeholderLabel)
    }
}

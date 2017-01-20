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
    
    @objc fileprivate func textChanged() {
        placeholderLabel.isHidden = self.hasText
    }

}
// 表情键盘专属方法
extension WeiBoComposeTextView {
    func insertEmoticon(em: Emoticon?) {
        // em == nil 是删除按钮
        guard let em = em else {
            // 删除文本
            deleteBackward()
            return
        }
        
        if let emoji = em.emoji, let textRange = selectedTextRange {
            
            replace(textRange, withText: emoji)
            return
        }
        
        let imageText = em.imageText(font: font!)
        // 修复图像越来越小
        // 获取当前textView属性文本
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        
        // 将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharacters(in: selectedRange, with: imageText)
        
        let range = selectedRange
        
        // 设置文本
        attributedText = attrStrM
        // 恢复光标的位置
        selectedRange = NSRange(location: range.location + 1, length: range.length)
        
        // 让代理执行文本变化方法
        delegate?.textViewDidChange?(self)
        
        // 执行当前对象的文本变化
        textChanged()
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

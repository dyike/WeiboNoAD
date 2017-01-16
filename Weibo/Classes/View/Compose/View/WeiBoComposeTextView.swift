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

}

private extension WeiBoComposeTextView {
    
    func setupUI() {
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        placeholderLabel.sizeToFit()
        
        addSubview(placeholderLabel)
    }
}

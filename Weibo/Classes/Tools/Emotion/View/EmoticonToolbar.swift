//
//  EmoticonToolbar.swift
//  Weibo
//
//  Created by ityike on 2017/1/18.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class EmoticonToolbar: UIView {

    override func awakeFromNib() {
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = subviews.count
        let width = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        for (idx, btn) in subviews.enumerated() {
            
            btn.frame = rect.offsetBy(dx: CGFloat(idx) * width, dy: 0)
        }
    }
}


private extension EmoticonToolbar {
    
    func setupUI() {
        let manager = EmoticonManager.shared
        
        for p in manager.packages {
            let btn = UIButton()
            btn.setTitle(p.groupName, for: [])
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: [])
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            
            btn.sizeToFit()
            
            addSubview(btn)
        }
        
    }
}

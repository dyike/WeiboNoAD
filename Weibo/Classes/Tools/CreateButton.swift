//
//  CreateButton.swift
//  Weibo
//
//  Created by ityike on 2016/12/24.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class CreateButtion: UIButton {
    //屏蔽按钮的高亮效果
    override var isHighlighted: Bool {
        get {
            return false;
        }
        set {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 设置视图
    func setupUI() {
        // imageView
        imageView?.contentMode = .center
        // title
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        setTitleColor(UIColor(red: 0.05, green: 0.38, blue: 0.56, alpha: 0.5), for: UIControlState.normal)
        setImage(UIImage(named: "tabbar_add"), for: UIControlState.normal)
        setImage(UIImage(named: "tabbar_add_seleted"), for: UIControlState.selected)
        sizeToFit()
    }
    
    // 对其子控件重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        // imageView
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        // title
        titleLabel?.frame = CGRect(x: 0, y: self.frame.width, width: self.frame.width, height: self.frame.height - self.frame.width)
    }
}

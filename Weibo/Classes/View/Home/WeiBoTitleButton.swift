//
//  WeiBoTitleButton.swift
//  Weibo
//
//  Created by ityike on 2017/1/7.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoTitleButton: UIButton {
    
    // 重载构造函数
    init(title: String?) {
        super.init(frame: CGRect())
        
        if title == nil {
            setTitle("首页", for: [])
        } else {
            setTitle(title, for: [])
            
            setImage(UIImage(named: "navigationbar_arrow_down"), for: [])
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        
        // 设置字体颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: [])
        
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  WeiBoComposeTypeView.swift
//  Weibo
//
//  Created by ityike on 2017/1/13.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 撰写微博类型视图
class WeiBoComposeTypeView: UIView {
    
    class func composeTypeView() ->WeiBoComposeTypeView {
        let nib = UINib(nibName: "WeiBoComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WeiBoComposeTypeView
        // XIB加载默认的600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    // 显示当前视图
    func show() {
        // 将当前视图添加到 根视图控制器 view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
    }
}

//
//  RefreshView.swift
//  Weibo
//
//  Created by ityike on 2017/1/12.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 刷新视图 
class RefreshView: UIView {

    // 提示图标
    @IBOutlet weak var tipIcon: UIImageView!
    // 提示标签
    @IBOutlet weak var tipLabel: UILabel!
    // 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView() -> RefreshView {
        let nib = UINib(nibName: "RefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! RefreshView
    }

}

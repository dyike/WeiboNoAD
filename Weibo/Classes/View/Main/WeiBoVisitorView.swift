//
//  WeiBoVisitorView.swift
//  Weibo
//
//  Created by ityike on 2016/12/28.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK - 设置界面
extension WeiBoVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
    }
}

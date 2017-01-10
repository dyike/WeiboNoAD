//
//  WeiBoStatusPictureView.swift
//  Weibo
//
//  Created by ityike on 2017/1/9.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoStatusPictureView: UIView {

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    

    override func awakeFromNib() {
        setupUI()
    }
}


extension WeiBoStatusPictureView {
    // cell中的所有控件都是提前准备好的
    // 设置的时候，根据数组决定是否显示
    fileprivate func setupUI() {
        // 超出便捷的内容不显示
        clipsToBounds = true
        
        let count = 3
        let rect = CGRect(x: 0, y: WeiBoStatusPictureViewOutterMargin, width: WeiBoStatusPictureItemWidth, height: WeiBoStatusPictureItemWidth)
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.backgroundColor = UIColor.red
            // 行
            let row = CGFloat(i / count)
            // 列
            let col = CGFloat(i % count)
            let dx = col * (WeiBoStatusPictureItemWidth + WeiBoStatusPictureViewInnerMargin)
            let dy = row * (WeiBoStatusPictureItemWidth + WeiBoStatusPictureViewInnerMargin)
            iv.frame = rect.offsetBy(dx: dx, dy: dy)
            addSubview(iv)
        }
    }
}

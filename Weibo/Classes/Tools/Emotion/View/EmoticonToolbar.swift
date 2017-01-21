//
//  EmoticonToolbar.swift
//  Weibo
//
//  Created by ityike on 2017/1/18.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

@objc protocol EmoticonToolbarDelegate: NSObjectProtocol {
    func emoticonToolbarDidSelectedItemIndex(toolbar: EmoticonToolbar, index: Int)
}

class EmoticonToolbar: UIView {
    
    weak var delegate: EmoticonToolbarDelegate?
    
    var selectedIndex: Int = 0 {
        didSet {
            for btn in subviews as! [UIButton] {
                btn.isSelected = false
            }
            (subviews[selectedIndex] as! UIButton).isSelected = true
        }
    }

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
    
    @objc fileprivate func clickItem(button: UIButton) {
        // 通知代理执行协议方法
        delegate?.emoticonToolbarDidSelectedItemIndex(toolbar: self, index: button.tag)
        
    }
}


private extension EmoticonToolbar {
    
    func setupUI() {
        let manager = EmoticonManager.shared
        
        for (i, p) in manager.packages.enumerated() {
            let btn = UIButton()
//            let imageEmoticon = "compose_emotion_table_\(p.imageName ?? "")"
//            var image = UIImage(named: imageEmoticon, in: manager.bundle, compatibleWith: nil)
            
            btn.setTitle(p.groupName, for: [])
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: [])
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            
            let imageName = "compose_emotion_table_\(p.bgImageName ?? "")_normal"
            let imageNameHL = "compose_emotion_table_\(p.bgImageName ?? "")_selected"
            var image = UIImage(named: imageName, in: manager.bundle, compatibleWith: nil)
            var imageHL = UIImage(named: imageNameHL, in: manager.bundle, compatibleWith: nil)
            
            let size = image?.size ?? CGSize()
            let inset = UIEdgeInsets(top: size.height * 0.5,
                                     left: size.width * 0.5,
                                     bottom: size.height * 0.5,
                                     right: size.width * 0.5)
            image = image?.resizableImage(withCapInsets: inset)
            imageHL = imageHL?.resizableImage(withCapInsets: inset)
            
            btn.setBackgroundImage(image, for: [])
            btn.setBackgroundImage(imageHL, for: .highlighted)
            btn.setBackgroundImage(imageHL, for: .selected)
            
            btn.sizeToFit()
            
            addSubview(btn)
            
            btn.tag = i
            btn.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        }
        
        (subviews[0] as! UIButton).isSelected = true
        
    }
}

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
        }
        
    }
}

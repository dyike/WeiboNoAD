//
//  TextButton.swift
//  Weibo
//
//  Created by ityike on 2016/12/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    init(frame: CGRect, imageName: String, selectedImageName: String) {
        super.init(frame: frame)
        
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: selectedImageName), for: UIControlState.selected)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 5
    }
}

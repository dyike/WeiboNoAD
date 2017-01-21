//
//  EmoticonTipView.swift
//  Weibo
//
//  Created by ityike on 2017/1/21.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import pop

class EmoticonTipView: UIImageView {
    
    private var preEmoticon: Emoticon?
    
    var emoticon: Emoticon? {
        didSet {
            if emoticon == preEmoticon {
                return
            }
            preEmoticon = emoticon
            // 设置表情数据
            tipButton.setTitle(emoticon?.emoji, for: [])
            tipButton.setImage(emoticon?.image, for: [])
            // 设置动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim.fromValue = 30
            anim.toValue = 8
            anim.springBounciness = 20
            anim.springSpeed = 20
            tipButton.layer.pop_add(anim, forKey: nil)
        }
    }
    
    // MARK - 私有控件
    private lazy var tipButton = UIButton()
    
    init() {
        let bundle = EmoticonManager.shared.bundle
        let image = UIImage(named: "emoticon_keyboard_magnifier", in: bundle, compatibleWith: nil)
        super.init(image: image)
        // 设置锚点
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.2)
        
        tipButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        tipButton.frame = CGRect(x: 0, y: 8, width: 36, height: 36)
        tipButton.center.x = bounds.width * 0.50
        tipButton.setTitle("😁", for: [])
        tipButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        addSubview(tipButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

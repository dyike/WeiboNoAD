//
//  EmoticonCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/19.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit


@objc protocol EmoticonCellDelegate: NSObjectProtocol {
    func emoticonCellDidSelectedEmoticon(cell: EmoticonCell, em: Emoticon?)
}

class EmoticonCell: UICollectionViewCell {
    
    // 代理
    weak var delegate: EmoticonCellDelegate?
    
    var emoticons: [Emoticon]? {
        didSet {
            // 1 隐藏所有的按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            // 显示最后一个删除按钮
            contentView.subviews.last?.isHidden = false
            // 2 遍历表情数组模型，设置按钮图象
            for (i, em) in (emoticons ?? []).enumerated() {
                // 1 取出按钮 
                if let btn = contentView.subviews[i] as? UIButton {
                    btn.setImage(em.image, for: [])
                    
                    btn.setTitle(em.emoji, for: [])
                    
                    btn.isHidden = false
                }
            }
        }
    }
    
    private lazy var tipView = EmoticonTipView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        guard let window = newWindow else {
            return
        }
        
        window.addSubview(tipView)
        tipView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectedEmoticonButton(button: UIButton) {
        let tag = button.tag
        var em: Emoticon?
        // 每一个最多20个表情。0-19
        if tag < 20 {
            em = emoticons?[tag]
        }
        delegate?.emoticonCellDidSelectedEmoticon(cell: self, em: em)
    }
    
    
    @objc func longGesture(gesture: UILongPressGestureRecognizer) {
        // 获取触摸位置
        let location = gesture.location(in: self)
        // 获取触摸位置的对应按钮
        guard let button = buttonWithLocation(location: location) else {
            tipView.isHidden = true
            return
        }
        
        // 处理手势状态
        switch gesture.state {
        case .began, .changed:
            tipView.isHidden = false
            // 坐标系的转换
            let center = self.convert(button.center, to: window)
            tipView.center = center
            // 设置表情模型
            if button.tag < (emoticons?.count)! {
                tipView.emoticon = emoticons?[button.tag]
            }
        case .ended:
            tipView.isHidden = true
            // 执行选中的按钮
            selectedEmoticonButton(button: button)
        case .cancelled, .failed:
            tipView.isHidden = true
        default:
            break
        }
    }
    
    private func buttonWithLocation(location: CGPoint) -> UIButton? {
        for btn in contentView.subviews as! [UIButton] {
            if btn.frame.contains(location) && !btn.isHidden && btn != contentView.subviews.last {
                return btn
            }
        }
        return nil
    }
}

private extension EmoticonCell {
    func setupUI() {
        
        let rowCount = 3
        let colCount = 7
        let leftMargin: CGFloat = 8
        let bottomMargin: CGFloat = 16
        
        let width = (bounds.width - 2 * leftMargin) / CGFloat(colCount)
        let height = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        // 创建21个按钮
        for i in 0..<21 {
            let row = i / colCount
            let col = i % colCount
            
            let btn = UIButton()
            let x = leftMargin + CGFloat(col) * width
            let y = CGFloat(row) * height
            btn.frame = CGRect(x: x, y: y, width: width, height: height)
            
            contentView.addSubview(btn)
            
            //设置按钮字体大小
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
            // 设置按钮的tag
            btn.tag = i
            btn.addTarget(self, action: #selector(selectedEmoticonButton), for: .touchUpInside)
        }
        
        let removeButton = contentView.subviews.last as! UIButton
        let image = UIImage(named: "compose_emotion_delete", in: EmoticonManager.shared.bundle, compatibleWith: nil)
        removeButton.setImage(image, for: [])
        
        // 长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        longPress.minimumPressDuration = 0.1
        addGestureRecognizer(longPress)
        
    }
}

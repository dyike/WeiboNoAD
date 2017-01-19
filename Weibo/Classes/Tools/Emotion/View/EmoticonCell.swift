//
//  EmoticonCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/19.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    var emoticons: [Emoticon]? {
        didSet {
            // 1 隐藏所有的按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            // 2 遍历表情数组模型，设置按钮图象
            for (i, em) in (emoticons ?? []).enumerated() {
                // 1 取出按钮 
                if let btn = contentView.subviews[i] as? UIButton {
                    btn.setImage(em.image, for: [])
                    btn.isHidden = false
                }
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        setupUI()
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
            
            //btn.backgroundColor = UIColor.red
            contentView.addSubview(btn)
        }
    }
}

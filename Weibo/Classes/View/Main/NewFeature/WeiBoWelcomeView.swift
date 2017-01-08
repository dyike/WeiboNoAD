//
//  WeiBoWelcomeView.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import SDWebImage

// 欢迎视图
class WeiBoWelcomeView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView() -> WeiBoWelcomeView {
        let nib = UINib(nibName: "WeiBoWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WeiBoWelcomeView
        // 从xib加载视图，默认是600*600
        v.frame = UIScreen.main.bounds
        return v
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //提示：initWithCoder 只是刚刚从XIB的二进制文件将试图数据加载完成
        // 还没有和代码建立联系关系，所以千万不要在这个方法里面处理UI
        // print("initWithCoder +\(iconView)")
    }
    
    override func awakeFromNib() {
        // print("awakeFromNib +\(iconView)")
        guard let urlString = WeiBoNetWorkManager.shared.userAccount.avatar_large,
            let url = URL(string: urlString) else {
            return
        }
        // 设置头像 如果网络图象没有下载完成，先显示占位图象
        // 如果不指定占位图象，之前设置的图象会被清空
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        // 设置圆角
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
    }
    
    
    // 视图被添加到window上，表示视图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        // 视图使用自动布局来设置的，只是设置了约束
        // 当视图被添加到窗口上，根据父视图的大小，计算约束值，更新控件位置
        // layoutIfNeeded 会直接按照当前的约束直接更新控件的位置
        // 执行之后，控件所在位置就是XIB中布局的位置
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        // 如果控件们，frame还没有计算好，所有约束会一起动画
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        //更新约束
                        self.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1.0, animations: {
                    self.tipLabel.alpha = 1
                }, completion: { (_) in
                    self.removeFromSuperview()
            })
        }
    }
}

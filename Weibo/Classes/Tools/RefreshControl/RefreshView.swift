//
//  RefreshView.swift
//  Weibo
//
//  Created by ityike on 2017/1/12.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 刷新视图 负责刷新相关的UI 和 动画
class RefreshView: UIView {
    
    /**
     iOS 系统中 UIView 封装的旋转动画
     - 默认顺时针旋转
     - 就近原则
     - 要想实现同方向旋转，需要调整一个 非常小的数字(近)
     - 如果想实现 360 旋转，需要核心动画 CABaseAnimation
     */
    var refreshState: RefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                // 恢复状态
                tipIcon.isHidden = false
                indicator.stopAnimating()
                
                tipLabel.text = "下拉刷新"
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon.transform = CGAffineTransform.identity
                })
            case .Pulling:
                tipLabel.text = "释放更新"
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI + 0.001))
                })
                
            case .WillRefresh:
                tipLabel.text = "加载中"
                // 隐藏提示图标
                tipIcon?.isHidden = true
                // 显示菊花
                indicator?.startAnimating()
                
            }
        }
    }

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

//
//  WeiBoComposeTypeView.swift
//  Weibo
//
//  Created by ityike on 2017/1/13.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit
import pop

// 撰写微博类型视图
class WeiBoComposeTypeView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    // 关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    // 返回前一页按钮约束
    @IBOutlet weak var returnButtonCenterXCons: NSLayoutConstraint!
    // 返回前一页按钮
    @IBOutlet weak var returnButton: UIButton!
    
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字"],
                              ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                              ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                              ["imageName": "tabbar_compose_lbs", "title": "签到"],
                              ["imageName": "tabbar_compose_review", "title": "点评"],
                              ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                              ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                              ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                              ["imageName": "tabbar_compose_music", "title": "音乐"],
                              ["imageName": "tabbar_compose_shooting", "title": "秒拍"]
        ]
    
    class func composeTypeView() ->WeiBoComposeTypeView {
        let nib = UINib(nibName: "WeiBoComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WeiBoComposeTypeView
        // XIB加载默认的600 * 600
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }
    
    // 显示当前视图
    func show() {
        // 将当前视图添加到 根视图控制器 view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
        
        // 开始动画
        showCurrentView()
    }


    
    /// 关闭视图
    @IBAction func close() {
        heideButtons()
        removeFromSuperview()
    }
    
    @objc fileprivate func clickMore() {
        // 将scrollView滚动到第二页
        let offSet = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(offSet, animated: true)
        // 处理底部按钮， 让按钮都分开，一个向左，一个向右
        returnButton.isHidden = false
        let margin = scrollView.bounds.width / 4
        closeButtonCenterXCons.constant += margin
        returnButtonCenterXCons.constant -= margin
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
    }
    
    @IBAction func clickReturn() {
        // 1 将滚动视图滚动到第一页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        // 两个按钮合并
        closeButtonCenterXCons.constant = 0
        returnButtonCenterXCons.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
        }) { _ in
            // 隐藏返回按钮
            self.returnButton.isHidden = true
            self.returnButton.alpha = 1
        }
    }
    

    // MARK - 监听方法
    @objc fileprivate func clickButton() {
        print("xieweibo")
    }
}
// private 让extension中的所有方法都私有
private extension WeiBoComposeTypeView {
    func setupUI() {
        // 强行更新布局
        layoutIfNeeded()
        // 向scrollView添加视图
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            // 向视图添加按钮
            addButtons(v: v, idx: i * 6)
            // 将视图添加到scrollView
            scrollView.addSubview(v)
        }
        // 设置scrollView
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        // 禁用滚动
        scrollView.isScrollEnabled = false
    }
    
    // 向v中添加按钮，按钮的数组索引开始
    func addButtons(v: UIView, idx: Int) {
        let count = 6
        // 从index开始
        for i in idx..<(idx + count) {
            
            if i >= buttonsInfo.count {
                break
            }
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            let btn = WeiBoComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            v.addSubview(btn)
            // 添加监听方法
            if let actionName = dict["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
        }
        // 布局按钮
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i, btn) in v.subviews.enumerated() {
            let y: CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let x = CGFloat(i % 3 + 1) * margin + CGFloat(i % 3) * btnSize.width
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}

// MARK - 动画扩展
private extension WeiBoComposeTypeView {
    // 动画显示当前视图
    func showCurrentView() {
        // 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        
        // 添加到视图
        pop_add(anim, forKey: nil)
        
        // 添加按钮动画
        showButton()
    }
    
    // 弹力显示所有的按钮
    func showButton() {
        // 1 获取scrollview 的子视图的第 0 个视图
        let v = scrollView.subviews[0]
        // 2 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated() {
            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            // 设置动画属性
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y
            // 弹力系数
            anim.springBounciness = 8
            // 弹力速度
            anim.springSpeed = 6
            
            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            
            // 添加动画
            btn.pop_add(anim, forKey: nil)
            
        }
    }
    
    // MARK - 消除动画  隐藏按钮
    func heideButtons() {
        // 根据 contentOffset 判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 遍历 v 中所有的按钮
        for (i, btn) in v.subviews.enumerated().reversed() {
            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            // 设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            // 添加动画
            btn.layer.pop_add(anim, forKey: nil)
            
        }
    }
    
    
    
    
}







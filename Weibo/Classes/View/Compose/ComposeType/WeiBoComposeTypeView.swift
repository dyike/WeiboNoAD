//
//  WeiBoComposeTypeView.swift
//  Weibo
//
//  Created by ityike on 2017/1/13.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 撰写微博类型视图
class WeiBoComposeTypeView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字"],
                              ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                              ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                              ["imageName": "tabbar_compose_lbs", "title": "签到"],
                              ["imageName": "tabbar_compose_review", "title": "点评"],
                              ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                              ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                              ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                              ["imageName": "tabbar_compose_music", "title": "音乐"],
                              ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
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
    }

    
    /// 关闭视图
    @IBAction func close() {
        removeFromSuperview()
    }
    
    @objc fileprivate func clickMore() {
        print("点击更多")
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








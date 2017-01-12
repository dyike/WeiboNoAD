//
//  RefreshControl.swift
//  Weibo
//
//  Created by ityike on 2017/1/12.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 刷新控件  负责刷新相关的逻辑处理
class RefreshControl: UIControl {
    
    // 刷新控件的父视图，下拉刷新控件应该使用与 UITableView / UICollectionView
    private weak var scrollView: UIScrollView?
    
    // 刷新视图
    fileprivate lazy var refreshView: RefreshView = RefreshView.refreshView()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 记录父视图
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        scrollView = sv
        
        // kvo 监听父视图 contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    // 本视图从父视图上移除
    override func removeFromSuperview() {
        // superview还在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
    }
    
    // 所有 KVO 方法会统一调用此方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            return
        }
        // 初始高度为0
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        // 可以根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
    }
    
    // 开始刷新
    func beginRefreshing() {
        
    }
    
    // 结束刷新
    func endRefreshing() {
        
    }

}

extension RefreshControl {
    func setupUI() {
        backgroundColor = superview?.backgroundColor
        
        // 设置超出边界不显示
        clipsToBounds = true
        
        // 添加刷新视图 从xib加载出来，默认是xib中的指定的高度
        addSubview(refreshView)
        
        // 自动布局
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
        
    }
}







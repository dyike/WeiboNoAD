//
//  RefreshControl.swift
//  Weibo
//
//  Created by ityike on 2017/1/12.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 刷新控件
class RefreshControl: UIControl {
    
    // 刷新控件的父视图，下拉刷新控件应该使用与 UITableView / UICollectionView
    private weak var scrollView: UIScrollView?
    
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
        backgroundColor = UIColor.orange
    }
}








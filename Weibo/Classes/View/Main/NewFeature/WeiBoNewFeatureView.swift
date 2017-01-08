//
//  WeiBoNewFeatureView.swift
//  Weibo
//
//  Created by ityike on 2017/1/8.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

// 新特性视图
class WeiBoNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    //进入微博
    @IBAction func enterStatus() {
        removeFromSuperview()
    }
    
    
    class func newFeatureView() -> WeiBoNewFeatureView {
        let nib = UINib(nibName: "WeiBoNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WeiBoNewFeatureView
        // 从xib加载视图，默认是600*600
        v.frame = UIScreen.main.bounds
        return v
    }
    
    
    override func awakeFromNib() {
        // 使用自动布局设置的界面，从XIB加载默认600*600大小
        // 添加4个图象视图
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        // 指定scrollView的属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        scrollView.delegate = self
        
        // 隐藏按钮
        enterButton.isHidden = true
    }
}

extension WeiBoNewFeatureView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滚动到最后一屏，让视图删除
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        // 判断是否最后一页
        if Int(page) == scrollView.subviews.count {
            removeFromSuperview()
        }
        // 如果倒数第二页显示按钮
        enterButton.isHidden = (Int(page) != scrollView.subviews.count - 1)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动就隐藏按钮
        enterButton.isHidden = true
        // 计算当前的偏移量
        let page = scrollView.contentOffset.x / scrollView.bounds.width + 0.5
        // 设置分页控件
        pageControl.currentPage = Int(page)
        
        // 分页控件隐藏
        pageControl.isHidden = (Int(page) == scrollView.subviews.count)
    }
}









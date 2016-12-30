//
//  WeiBoHomeViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoHomeViewController: WeiBoBaseViewController {
    // 微博数据数组
    lazy var statusList = [String]()
    
    override func loadData() {
        // 模拟延时加载数据 -> dispatch_after
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {

            for i in 0..<15 {
                if self.isPullUp {
                    // 将数据加载到底部
                    self.statusList.append("上拉 \(i)")
                }
                self.statusList.insert(i.description, at: 0)
            }

            // 结束刷新
            self.refreshControl?.endRefreshing()
            // 恢复上来刷新标记
            self.isPullUp = false
            // 刷新表格
            self.tableView?.reloadData()
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    @objc func showFriends() {
        let vc = WeiboDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

// 设置界面
extension WeiBoHomeViewController {
    override func setupUI() {
        super.setupUI()
        
        // 设置导航栏按钮
        // 无法高亮
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", fontSize: 16, target: self, action: #selector(showFriends), isBack: true)
        
        
    }
}

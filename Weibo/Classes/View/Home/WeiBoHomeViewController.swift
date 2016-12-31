//
//  WeiBoHomeViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

// 定义全局常量，private修饰，否则到处可访问
private let cellId = "cellId"

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
    }
    
    // 显示好友
    @objc func showFriends() {
        let vc = WeiboDemoViewController()
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }

}
// MARK - 表格数据源方法,具体数据源方法实现，不需要super
extension WeiBoHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // 2 设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        // 3 返回cell
        return cell
    }
    
}

// 设置界面
extension WeiBoHomeViewController {
    // 重写父类方法
    override func setupTableView() {
        super.setupTableView()
        
        // 设置导航栏按钮
        // 无法高亮
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        // 注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
}

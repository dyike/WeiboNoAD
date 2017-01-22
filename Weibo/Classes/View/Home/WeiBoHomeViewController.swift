//
//  WeiBoHomeViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

// 定义全局常量，private修饰，否则到处可访问
// 原创微博
private let originalCellId = "originalCellId"
// 转发微博
private let retweetedCellId =  "retweetedCellId"

class WeiBoHomeViewController: WeiBoBaseViewController {
    // 列表视图模型
    lazy var listViewModel = WeiboStatusListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(browserPhoto),
            name: NSNotification.Name(rawValue: WeiBoStatusCellBrowserPhotoNotification),
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func browserPhoto(n: Notification) {
        guard let selectedIndex = n.userInfo?[WeiBoStatusCellBrowserPhotoSelectedIndexKey] as? Int,
            let urls = n.userInfo?[WeiBoStatusCellBrowserPhotoURLsKey] as? [String],
            let _ = n.userInfo?[WeiBoStatusCellBrowserPhotoImageViewsKey] as? [UIImageView] else {
                return
        }

        // 创建控制器
        let photoBrowser = WeiBoPhotoBrowserController(selectedIndex: selectedIndex, urls: urls)
        
        photoBrowser.modalPresentationStyle = .custom
        
        // 以modal的形式弹出控制器
        present(photoBrowser, animated: true, completion: nil)
        
    }
    
    override func loadData() {
        
        listViewModel.loadStatus(pullup: self.isPullUp) { (isSuccess, shouldRefresh) in
            // 结束刷新
            self.refreshControl?.endRefreshing()
            // 恢复上来刷新标记
            self.isPullUp = false
            // 刷新表格
            if shouldRefresh {
               self.tableView?.reloadData()
            }
        }
        
    }
    
    // 显示好友
    @objc func showFriends() {
        let vc = WeiBoHomeViewController()
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }

}
// MARK - 表格数据源方法,具体数据源方法实现，不需要super
extension WeiBoHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取视图模型，根据视图模型判断可用cell
        let vm = listViewModel.statusList[indexPath.row]
        let cellId = (vm.status.retweeted_status != nil) ? retweetedCellId : originalCellId
        // 1 取cell
        // FIXME - 修改cellid
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WeiBoStatusCell
        // 2 设置cell
        cell.viewModel = vm
        
        // 设置代理
        cell.delegate = self
        
        // 3 返回cell
        return cell
    }
    
    // swift2 没有override， siwft3不写没关系
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 根据indexPath 获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        // 返回计算行高
        return vm.rowHeight
    }
    
}

extension WeiBoHomeViewController: WeiBoStatusCellDelegate {
    @objc internal func statusCellDidSelectedURLString(cell: WeiBoStatusCell, urlString: String) {
        //print(urlString)
        let vc = WeiBoWebViewController()
        vc.urlString = urlString
        navigationController?.pushViewController(vc, animated: true)
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
        //tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.register(UINib(nibName: "WeiBoStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName: "WeiBoStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        // 设置行高
        // 取消自动行高
        //tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        // 取消分割线
        tableView?.separatorStyle = .none
        
        setupNavTitle()
    }
    
    // 设置导航栏标题
    private func setupNavTitle() {
        let title = WeiBoNetWorkManager.shared.userAccount.screen_name
        let button = WeiBoTitleButton(title: title)
        
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn: UIButton) {
        // 设置选中状态
        btn.isSelected = !btn.isSelected
    }
}

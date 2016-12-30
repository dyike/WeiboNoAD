//
//  WeiBoBaseViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoBaseViewController: UIViewController {
<<<<<<< HEAD
    // 用户登陆状态
    var userLogon = false
    
    var visitorInfoDictionary: [String: String]?
    
    // 表格视图  - 如果用户没有登陆，就不创建
    var tableView: UITableView?
    // 刷新控件
    var refreshControl: UIRefreshControl?
    
    // 标记是否上拉
    var isPullUp = false
 
=======

>>>>>>> parent of 3e4b402... tableViewCell
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
    // 自定义导航条目 以后设置导航栏内容使用navItem
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
<<<<<<< HEAD
    // 加载数据  具体实现由子类负责
    func loadData() {
        refreshControl?.endRefreshing()
    }
    
=======
>>>>>>> parent of 3e4b402... tableViewCell
}


extension WeiBoBaseViewController {
    func setupUI() {
<<<<<<< HEAD
        view.backgroundColor = UIColor.white
        // 取消自动缩进 - 如果隐藏了导航栏，会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        userLogon ? setupTableView() : setupVisitorView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源 & 代理 -> 目的：子类直接获取数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 0,
                                               right: 0)
        // 设置刷新控件
        // 1 实例化控件
        refreshControl = UIRefreshControl()
        // 2 添加到表格视图
        tableView?.addSubview(refreshControl!)
        // 3 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    // 设置访客视图
    private func setupVisitorView() {
        let vistiorView = WeiBoVisitorView(frame: view.bounds)
        view.insertSubview(vistiorView, belowSubview: navigationBar)
        // 设置访客视图信息
        vistiorView.visitorInfo = visitorInfoDictionary
    }
    
    
    private func setupNavigationBar() {
=======
>>>>>>> parent of 3e4b402... tableViewCell
        // 添加导航条
        view.addSubview(navigationBar)
        // 将 item 设置给bar
        navigationBar.items = [navItem]
        // 设置navBar 的渲染颜色
        navigationBar.barTintColor = UIColor.white
        // 设置navBar 的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
    }
}

<<<<<<< HEAD
extension WeiBoBaseViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // 在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1 判断indexPath是否是最后一行(indexPath.section(最大), indexPath.row(最后一行))
        let row = indexPath.row
        // 2 section
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
            return
        }
        // 3 行数
        let lineCount = tableView.numberOfRows(inSection: section)
        // 如果是最后一行，同时没有开始上来刷新
        if row == (lineCount - 1) && !isPullUp {
            isPullUp = true
            // 开始刷新
            loadData()
        }
    }
}

=======
>>>>>>> parent of 3e4b402... tableViewCell

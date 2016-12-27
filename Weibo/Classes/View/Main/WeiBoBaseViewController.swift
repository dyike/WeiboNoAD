//
//  WeiBoBaseViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

//class WeiBoBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

class WeiBoBaseViewController: UIViewController {
    // 表格视图  - 如果用户没有登陆，就不创建
    var tableView: UITableView?
 
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
    // 自定义导航条目 以后设置导航栏内容使用navItem
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // 加载数据
    func loadData() {
        
    }
    
}

// MARK - 设置界面
extension WeiBoBaseViewController {
    func setupUI() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源 & 代理 -> 目的：子类直接获取数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    
    private func setupNavigationBar() {
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

extension WeiBoBaseViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


//
//  WeiBoBaseViewController.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}


extension WeiBoBaseViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white
    }
}


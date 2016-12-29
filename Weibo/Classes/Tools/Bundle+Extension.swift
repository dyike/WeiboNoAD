//
//  Bundle+Extension.swift
//  Weibo
//
//  Created by ityike on 2016/12/21.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import Foundation

extension Bundle {
    //返回命名空间字符串
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

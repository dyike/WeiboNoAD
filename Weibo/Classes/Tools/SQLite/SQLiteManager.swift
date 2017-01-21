//
//  SQLiteManager.swift
//  Weibo
//
//  Created by ityike on 2017/1/21.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation
import FMDB

class SQLiteManager {
    static let shared = SQLiteManager()
    
    let queue: FMDatabaseQueue
    
    private init() {
        // 数据库的全路径 - path
        let dbName = "status.db"
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        
        // 创建数据库队列, 同时创建或者打开数据库
        queue = FMDatabaseQueue(path: path)
        

    }
}

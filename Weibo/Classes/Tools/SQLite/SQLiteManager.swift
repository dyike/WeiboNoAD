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
        
        createTable()

    }
}

extension SQLiteManager {
    // userId: 当前用户的id
    // array: 从网络上获取的字典数组
    func updateStatus(userId: String, array: [[String: AnyObject]]) {
        let sql = "INSERT OR REPLACE INTO weibo_status (statusId, userId, status) VALUES (?, ?, ?);"
        
        queue.inTransaction { (db, rollback) in
            for dict in array {
                guard let statusId = dict["idstr"] as? String,
                // 将字典序列化二进制数据
                    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                        continue
                }
                
                if db?.executeUpdate(sql, withArgumentsIn: [statusId, userId, jsonData]) == false {
                    rollback?.pointee = true   // 3.0 写法
                    break
                }
            }
        }
    }
    
    // 从数据库加载微博数据
    func loadStatus(userId: String, since_id: Int64 = 0, max_id: Int64 = 0) -> [[String: AnyObject]] {
        var sql = "SELECT statusId, userId, status FROM weibo_status \n"
        sql += "WHERE userId = \(userId) \n"
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        } else if max_id > 0 {
            sql += "AND statusId > \(max_id) \n"
        }
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        let array = execRecordSet(sql: sql)
        var result = [[String: AnyObject]]()
        
        for dict in array {
            guard let jsonData = dict["status"] as? Data,
                let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject] else {
                continue
            }
            result.append(json ?? [:])
        }
        
        return result
    }
}

private extension SQLiteManager {
    func createTable() {
        guard let path = Bundle.main.path(forResource: "status.sql", ofType: nil),
            let sql = try? String(contentsOfFile: path) else {
            return
        }
        
        //print(sql) 
        // FMDB 内部的队列是串行队列，同步执行
        queue.inDatabase { (db) in
            if db?.executeStatements(sql) == true {
//                print("创表成功")
            } else {
                print("创表失败")
            }
        }
    }
    
    
    // 执行sql，返回一个字典的数据
    func execRecordSet(sql: String) -> [[String: AnyObject]] {
        var result = [[String: AnyObject]]()        
        queue.inDatabase { (db) in
            guard let res = db?.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            
            while res.next() {
                // 列数
                let colCount = res.columnCount()
                // 遍历所有列
                for col in 0..<colCount {
                    guard let name = res.columnName(for: col),
                        let value = res.object(forColumnIndex: col) else {
                        continue
                    }
                    
                    result.append([name: value as AnyObject])
                }
            }
        }
        return result
    }
}

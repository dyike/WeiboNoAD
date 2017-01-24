//
//  Date+Extension.swift
//  Weibo
//
//  Created by ityike on 2017/1/17.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation

// 不要频繁的创建释放
private let dateFormatter = DateFormatter()

extension Date {
    
    struct DateStatic {
        static let formatterFullDate: DateFormatter = {
            dateFormatter.dateFormat = "yy-m-d"
            dateFormatter.locale = NSLocale.current
            return dateFormatter
        }()
    }
    
    
    func dateByString() -> String {
        let now = Date()
        let delta = now.timeIntervalSince1970 - self.timeIntervalSince1970;
        
        if delta < 60 {
            return "刚刚"
        } else if delta < 60 * 60 {
            return "\(Int(delta / 60))分钟前"
        } else if delta < 60 * 60 * 24 {
            return "\(Int(delta / 3600))小时前"
        } else if delta < 60 * 60 * 24 * 7 {
            return "\(Int(delta / 3600 / 24))天前"
        } else {
            return DateStatic.formatterFullDate.string(from: self)
        }
    }
    
    static func dateString(delta: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: delta)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}

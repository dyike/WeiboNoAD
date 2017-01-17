//
//  Date+Extension.swift
//  Weibo
//
//  Created by ityike on 2017/1/17.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation


extension Date {
    
    struct DateStatic {
        static let formatterFullDate: DateFormatter = {
            let formatterFullDate = DateFormatter()
            formatterFullDate.dateFormat = "yy-m-d"
            formatterFullDate.locale = NSLocale.current
            return formatterFullDate
        }()
    }
    
    
    func dateByString() -> String {
        let now = Date()
        let delta = now.timeIntervalSince1970 - self.timeIntervalSince1970;
        
        if delta < 60 * 3 {
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
    
}

//
//  ChecklistItem.swift
//  Checklists
//
//  Created by yuanfeng on 16/2/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}


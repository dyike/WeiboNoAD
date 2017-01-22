//
//  WeiBoPicPickerViewCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoPicPickerViewCell: UICollectionViewCell {

    
    @IBAction func addPhotoClick() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoPicPickerAddPhoto), object: nil)
        
    }

}

//
//  WeiBoPicPickerViewCell.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class WeiBoPicPickerViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var addPhotoButton: UIButton!

    @IBOutlet weak var removePhotoButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        
        didSet {
            if image != nil {
                imageView.image = image
                addPhotoButton.isUserInteractionEnabled = false
                removePhotoButton.isHidden = false
            } else {
                imageView.image = nil
                addPhotoButton.isUserInteractionEnabled = true
                removePhotoButton.isHidden = true
            }
        }
    
    }
    
    @IBAction func addPhotoClick() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoPicPickerAddPhoto), object: nil)
        
    }
    @IBAction func removePhotoClick() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoPicPickerRemovePhoto), object: imageView.image)
    }

}

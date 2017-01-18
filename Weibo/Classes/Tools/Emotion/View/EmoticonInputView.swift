//
//  EmoticonInputView.swift
//  Weibo
//
//  Created by ityike on 2017/1/18.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

class EmoticonInputView: UIView {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolbar: UIView!
    
    class func inputView() -> EmoticonInputView {
        let nib = UINib(nibName: "EmoticonInputView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! EmoticonInputView
        return v
    }

}

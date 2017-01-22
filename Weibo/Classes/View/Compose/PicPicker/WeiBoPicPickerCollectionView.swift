//
//  WeiBoPicPickerCollectionView.swift
//  Weibo
//
//  Created by ityike on 2017/1/22.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit

private let picPickerCell = "picPickerCell"
private let margin: CGFloat = 12


class WeiBoPicPickerCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置collectionView属性
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let ietmeWidth = (UIScreen.main.bounds.width - 4 * margin) / 3
        layout.itemSize = CGSize(width: ietmeWidth, height: ietmeWidth)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        let uiNibName = UINib(nibName: "WeiBoPicPickerViewCell", bundle: nil)
        register(uiNibName, forCellWithReuseIdentifier: picPickerCell)
        dataSource = self
        
        // 设置collectionView的内边距
        contentInset = UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
    }
}


extension WeiBoPicPickerCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCell, for: indexPath)
        
        // 设置cell数据
        cell.backgroundColor = UIColor.red
        
        return cell
    }

}

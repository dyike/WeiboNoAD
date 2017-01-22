//
//  WeiBoCommon.swift
//  Weibo
//
//  Created by ityike on 2017/1/2.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation
import UIKit

// MARK - 全局通知定义

let WeiBoUserShouldLoginNotification = "WeiBoUserShouldLoginNotification"
// 用户登陆成功通知
let WeiBoUserLoginSuccessedNotification = "WeiBoUserLoginSuccessedNotification"


// MARK - 应用程序信息
// AppKey
let WeiBoAppKey = "1139226012"
// 密钥
let WeiBoAppSecret = "b443d78786bf65e2fe93d92a6624bd7d"
// 回调地址
let WeiBoRedirectUri = "https://www.baidu.com"

// MARK 微博配图大小
// 配图外侧的间距
let WeiBoStatusPictureViewOutterMargin: CGFloat = 12
// 配图内部的间距
let WeiBoStatusPictureViewInnerMargin: CGFloat = 3
// 配图视图宽度
let WeiBoStatusPictureViewWidth = UIScreen.main.bounds.width - 2 * WeiBoStatusPictureViewOutterMargin
// 每个item的宽度
let WeiBoStatusPictureItemWidth = (WeiBoStatusPictureViewWidth - 2 * WeiBoStatusPictureViewInnerMargin) / 3

// 图片浏览通知
let WeiBoStatusCellBrowserPhotoNotification = "WeiBoStatusCellBrowserPhotoNotification"
let WeiBoStatusCellBrowserPhotoSelectedIndexKey = "WeiBoStatusCellBrowserPhotoSelectedIndexKey"
let WeiBoStatusCellBrowserPhotoURLsKey = "WeiBoStatusCellBrowserPhotoURLsKey"
let WeiBoStatusCellBrowserPhotoImageViewsKey = "WeiBoStatusCellBrowserPhotoImageViewsKey"

// 选择照片的通知常量
let WeiBoPicPickerAddPhoto = "WeiBoPicPickerAddPhoto"
let WeiBoPicPickerRemovePhoto = "WeiBoPicPickerRemovePhoto"

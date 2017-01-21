//
//  WeiboStatusListModel.swift
//  Weibo
//
//  Created by ityike on 2017/1/1.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import Foundation
import SDWebImage

// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 100

// 微博数据列表视图模型(微博数据处理)
// 父类的选择：
// 如果类使用“KVC”或者字典转模型框架设置对象值，类就需要继承自 NSObject
// 如果类知识包装一些代码逻辑，可以不使用任何父类，更加轻量
class WeiboStatusListModel {
    lazy var statusList = [WeiBoStatusViewModel]()
    // 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    func loadStatus(pullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        // 判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes {
            completion(true, false)
            return
        }
        
        // since_id 下拉 取出数组中第一条微博
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        // max_id 上拉，取出数组的最后一条微博
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        
//        WeiBoStatusListDAL.loadStatus(since_id: since_id, max_id: max_id) { (list, isSuccess) in
//        }
        // 发起网络请求，加载微博数据
        WeiBoNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 0 判断网络请求是否成功
            if !isSuccess {
                // 直接回调返回
                completion(false, false)
                return
            }
            
            // 1 字典转模型
            // 定义结果可变数组
            var array = [WeiBoStatusViewModel]()
            // 遍历服务器返回的字典数组，字典组模型
            for dict in list ?? [] {
                //print(dict["pic_urls"])
                
                let status = WeiBoStatus()
                
                status.yy_modelSet(with: dict)
                
                let viewModel = WeiBoStatusViewModel(model: status)
                // 将viewmodel添加到数组
                array.append(viewModel)
                // print("-----\(array)")
            }
        
            // 2 拼接数据
            if pullup {
                // 上拉刷新结束后，将结果拼接在数组末尾
                self.statusList += array
            } else {
                // 下拉刷新，应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
            // 3 判断上拉刷新的数据量
            if pullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess, false)
            } else {
                self.cacheSingleImage(list: array, finished: completion)
                // 完成回调
//                completion(isSuccess, true)
            }
            
        }
    }
    
    // 缓存本次下载微博数组中单张图象
    private func cacheSingleImage(list: [WeiBoStatusViewModel], finished: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        // 调度组
        let group = DispatchGroup()
        
        // 记录数据长度
        var length = 0
        // 遍历数组，查找数组中有单张图象的，进行缓存
        for vm in list {
            // 1 判断图象数量
            if vm.picURLs?.count != 1 {
                continue
            }
            // 2 获取图象模型
            guard let pic = vm.picURLs![0].thumbnail_pic,
                let url = URL(string: pic) else {
                continue
            }
      
            // 下载图象
            // 下载完成后自动保存在沙盒中
            // 如果沙盒中存在的，后续就使用SD通过URL加载图象，都会加载本地沙盒的图象
            // 不会发起网络请求，同时 回调方法，同样会被调用
            
            // A 入组
            group.enter()
            
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                
                // 将图像转换成二进制数据
                if let image = image,
                    let data = UIImagePNGRepresentation(image) {
                    // NSData 是 length 的属性
                    length += data.count
                    
                    // 图象缓存成功，更新配图大小
                    vm.updateSingalImageSize(image: image)
                }
                // B 出组
                group.leave()
                
            })
        }
        // C 监听调度组
        group.notify(queue: DispatchQueue.main) {
//            print(length / 1024 )
            finished(true, true)
        }
    }
}

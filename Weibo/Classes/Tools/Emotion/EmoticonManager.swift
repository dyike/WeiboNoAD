//
//  EmotionManager.swift
//  Weibo
//
//  Created by ityike on 2017/1/15.
//  Copyright © 2017年 袁 峰. All rights reserved.
//

import UIKit


class EmoticonManager {
    // 单例
    static let shared = EmoticonManager()
    
    // 表情包的懒加载数组
    lazy var packages = [EmoticonPackage]()
    
    // 表情素材的 bundle
    lazy var bundle: Bundle = {
        let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)
        
        return Bundle(path: path!)!
    }()
    
    private init() {
        loadPackages()
    }
    
    func recentEmoticon(em: Emoticon) {
        // 增加表情的使用次数
        em.times += 1
        // 判断是否记录了该表情，如果没有记录添加记录
        if !packages[0].emoticons.contains(em) {
            packages[0].emoticons.append(em)
        }
        // 根据使用次数排序，使用次数高的靠前
//        packages[0].emoticons.sort { (em1, em2) -> Bool in
//            return em1.times > em2.times
//        }
        packages[0].emoticons.sort { $0.times > $1.times }
        
        // 判断表情数组是否超出20，如果超出，删除末尾
        if packages[0].emoticons.count > 20 {
            packages[0].emoticons.removeSubrange(20..<packages[0].emoticons.count)
        }
        
    }
}

// MARK - 表情符号处理 查找表情图片
extension EmoticonManager {
    // 根据string在所有的表情符号中查找所有的表情模型对象
    func findEmoticon(string: String) -> Emoticon? {
        // 遍历表情包
        for p in packages {
            // 在表情数组中过滤string
            // 这是一个尾随闭包，还有一个最简单的写法
            // 闭包的格式定义可以省略，参数省略之后，，使用 $0, $1, $2...依次替代原有的参数
            // return也可以省略
            let result = p.emoticons.filter() { $0.chs == string }
//            let result = p.emoticons.filter( { (em) -> Bool in
//                return em.chs == string
//            })
            // 判断结果数组中的数量
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
    }
    
    
    // 将给定的字符串转换成表情属性文本
    func emoticonString(string: String, font: UIFont) -> NSAttributedString {
    
        let attrString = NSMutableAttributedString(string: string)
        
        // 建立正则表达式，过滤所有的表情文字
        let pattern = "\\[.*?\\]"
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        
        // 匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        
        for m in matches.reversed() {
            let r = m.rangeAt(0)
            let subStr = (attrString.string as NSString).substring(with: r)
            // 使用subStr查找对应的表情符号
            // if let em = EmoticonManager.shared.findEmoticon(string: subStr) {
            if let em = findEmoticon(string: subStr) {
                // 使用表情符号中的属性文本，替换原有的属性文本内容
                // 注意 需要倒序遍历，原因：顺序的话，替换了前面的之后，后面的范围会失效
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
        }
        // 统一设置字符串的属性
        attrString.addAttributes([NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: UIColor.black], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
}

private extension EmoticonManager {
    func loadPackages() {
        // 读取emotions.plist
        guard let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String: String]],
            let models = NSArray.yy_modelArray(with: EmoticonPackage.self, json: array) as? [EmoticonPackage] else {
            return
        }
        
        // 设置表情包数据
        // 使用+=不会再次分配内存空间
        packages += models
    }
}

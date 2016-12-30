//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by yuanfeng on 16/2/25.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller :ItemDetailViewController,didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController,didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: ItemDetailViewControllerDelegate?
    //var checklistViewController: ChecklistViewController
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "编辑条目"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancel(){
//        dismissViewControllerAnimated(true, completion: nil)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBAction func done(){
//        print("Contents of the text field: \(textField.text!)")
//        dismissViewControllerAnimated(true, completion: nil)
       
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            
        } else {
        //创建新的checklist item对象
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        
        //直接从ChecklistViewController调用一个方法
        //checklistViewController.addItem()
        delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //这个view controller 接收viewWillAppear()信息
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        //一旦有了新的文本，通过判断长度检查是否为空，并且doneBarButtion.enabled
//        if newText.length > 0 {
//            doneBarButton.enabled = true
//        } else {
//            doneBarButton.enabled = false
//        }
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
    
}

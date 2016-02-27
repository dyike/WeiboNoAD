//
//  ViewController.swift
//  Checklists
//
//  Created by yuanfeng on 16/2/23.
//  Copyright © 2016年 袁 峰. All rights reserved.
//

import UIKit


class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate{
    
    var checklist: Checklist!
    
//    @IBAction func addItem(){
//        //需要计算出数组中新的row
//        let newRowIndex = items.count
//        
//        let item = ChecklistItem()
//        item.text = "I am a new row"
//        item.checked = true
//        items.append(item)
//        
//        //table views用index-paths来识别rows
//        //首先创建一个NSIndexPath对象来指出新的row，用newRowIndex变量中的row number
//        //This index-path object now points to row 5(in section 0)
//        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
//        //创建一个新的临时的数组来保存index-path item
//        let indexPaths = [indexPath]
//        //最后告诉table view插入一个新的row
//        tableView.insertRowsAtIndexPaths(indexPaths,
//                                        withRowAnimation: .Automatic)
//        
//    }
//    var row0text = "遛狗"
//    var row1text = "刷牙"
//    var row2text = "吃早饭"
//    var row3text = "学习iOS"
//    var row4text = "锻炼身体"
//    var row0checked = false
//    var row1checked = true
//    var row2checked = true
//    var row3checked = false
//    var row4checked = true

    
//    //replace the rowXtext and rowXchecked instance variables
//    var row0item: ChecklistItem
//    var row1item: ChecklistItem
//    var row2item: ChecklistItem
//    var row3item: ChecklistItem
//    var row4item: ChecklistItem
    //定义checklistitem数组
    var items: [ChecklistItem]
    //解决替代变量后出现的错误"Class ChecklistViewController has no initializers"
    //初始化数组的value
    required init?(coder aDecoder: NSCoder) {
        
//        items = [ChecklistItem]()
        
//        let row0item = ChecklistItem()
//        row0item.text = "遛狗"
//        row0item.checked = false
//        items.append(row0item)
//        
//        let row1item = ChecklistItem()
//        row1item.text = "刷牙"
//        row1item.checked = true
//        items.append(row1item)
//        
//        let row2item = ChecklistItem()
//        row2item.text = "吃早饭"
//        row2item.checked = true
//        items.append(row2item)
//        
//        let row3item = ChecklistItem()
//        row3item.text = "学习iOS"
//        row3item.checked = false
//        items.append(row3item)
//        
//        let row4item = ChecklistItem()
//        row4item.text = "锻炼身体"
//        row4item.checked = true
//        items.append(row4item)
//        
//        let row5item = ChecklistItem()
//        row5item.text = "看电影"
//        row5item.checked = true
//        items.append(row5item)
//        
//        super.init(coder: aDecoder)
        
//
        
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
        //loadChecklistItems()
        
//        print("Documents folder is \(documentsDirectory())")
//        print("Data file path is \(dataFilePath())")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //send a "numberOfRowsInSection" message to find out how many rows are there
    //tableView(numberOfRowsInSection)
    override func tableView(
                            tableView: UITableView,
                            numberOfRowsInSection section: Int)
                            -> Int {
        return checklist.items.count
    }
    
    
    //when the table view needs to draw a particular row on the screen it sends the "cellForRowAtIndexPath" message to ask the data source for a cell
    //tableView(cellForRowAtIndexPath) to obtain a cell
    //tableView(cellForRowAtIndexPath)
    override func tableView(
                            tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath)
                            -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        //ask the table view cell for the view with tag 1000
        let label = cell.viewWithTag(1000) as! UILabel
        
        let item = checklist.items[indexPath.row]
        label.text = item.text
                 //等同于数组
//                if indexPath.row == 0 {
//                    label.text = row0item.text
//                }else if indexPath.row == 1 {
//                    label.text = row1item.text
//                }else if indexPath.row == 2 {
//                    label.text = row2item.text
//                }else if indexPath.row == 3 {
//                    label.text = row3item.text
//                }else if indexPath.row == 4 {
//                    label.text = row4item.text
//                }
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    
    //cell短暂地变成灰色，然后对钩又变成“取消选择”
    //tableView(didSelectRowAtIndexPath)
//    override func tableView(
//                            tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        //切换checkmark（对钩）,取消选择
//        if let cell = tableView.cellForRowAtIndexPath(indexPath){
//            if cell.accessoryType == .None {
//                cell.accessoryType = .Checkmark
//            }else {
//                cell.accessoryType = .None
//            }
//        }
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

    
    override func tableView(
                            tableView: UITableView, didSelectRowAtIndexPath
                                indexPath: NSIndexPath) {
    
            if let cell = tableView.cellForRowAtIndexPath(indexPath){
              let item = checklist.items[indexPath.row]
                //等同于数组
//                if indexPath.row == 0 {
//                    row0item.checked = !row0item.checked
//                } else if indexPath.row == 1 {
//                    row1item.checked = !row1item.checked
//                } else if indexPath.row == 2 {
//                    row2item.checked = !row2item.checked
//                } else if indexPath.row == 3 {
//                    row3item.checked = !row3item.checked
//                } else if indexPath.row == 4 {
//                    row4item.checked = !row4item.checked
//                }
                item.toggleChecked()
                configureCheckmarkForCell(cell, withChecklistItem: item)
                
           }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
         //   saveChecklistItems()
 }
  
    
    //删除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 1 remove the item from the data model
        checklist.items.removeAtIndex(indexPath.row)
        
        // 2 delete the corresponding row from the table view
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
         //   saveChecklistItems()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1 判断是否得到正确的segue
        if segue.identifier == "AddItem" {
            // 2 the new view controller能够在segue.destinationViewController找到
            let navigationController = segue.destinationViewController as! UINavigationController
            // 3 找出ItemDetailViewController，观察navigation Controller的topViewController的拥有权
            let controller = navigationController.topViewController as! ItemDetailViewController
            // 4 一旦对ItemDetailViewController对象有了一个参照，设置delegate property为self
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPAth = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPAth.row]
            }
        }
    }
    
    func configureTextForCell(cell: UITableViewCell,withChecklistItem item:ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    //indexPath: NSIndexPath ->withChecklistItem item: ChecklistItem
    func configureCheckmarkForCell(cell: UITableViewCell,withChecklistItem item: ChecklistItem) {
        
        //let item = items[indexPath.row]
        //等同于数组
//        
//        if indexPath.row == 0 {
//            isChecked = row0item.checked
//        } else if indexPath.row == 1 {
//            isChecked = row1item.checked
//        } else if indexPath.row == 2 {
//            isChecked = row2item.checked
//        } else if indexPath.row == 3 {
//            isChecked = row3item.checked
//        } else if indexPath.row == 4 {
//            isChecked = row4item.checked
//        }
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "✔️"
        } else {
            label.text = ""
        }
    }

    

    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.items.count
    
        checklist.items.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
        //   saveChecklistItems()
    }
    
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        
        if let index = checklist.items.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        //   saveChecklistItems()
    }
    
//    
//    func documentsDirectory() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(
//            .DocumentDirectory, .UserDomainMask, true)
//        return paths[0]
//    }
//    
//    func dataFilePath() -> String {
//        return (documentsDirectory() as NSString)
//            .stringByAppendingPathComponent("Checklists.plist")
    
        // or
//        let directory = documentsDirectory() as NSString
//        return directory.stringByAppendingPathComponent("Checklists.plist")
        
        //full path
//        return "\(documentsDirectory())/Checklists.plist"
//    }
    
//    func saveChecklistItems() {
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        archiver.encodeObject(items, forKey: "ChecklistItems")
//        archiver.finishEncoding()
//        data.writeToFile(dataFilePath(), atomically: true)
//    }

    //load
//    func loadChecklistItems() {
//        //1 put the results of dataFilePath() in a temporary constant named path
//        let path = dataFilePath()
//        //2检查文件是否存在，如果没有则没有加载
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            //3 当检查到有文件存在，从文件中加载整个数组及内容
//            if let data = NSData(contentsOfFile: path){
//                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
//                unarchiver.finishDecoding()
//            }
//        }
//    }

}




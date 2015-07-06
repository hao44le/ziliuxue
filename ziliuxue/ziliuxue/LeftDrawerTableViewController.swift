//
//  LeftDrawerTableViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 6/28/15.
//  Copyright © 2015 WangShuo. All rights reserved.
//

import UIKit

class LeftDrawerTableViewController: UITableViewController {
    
    
    @IBOutlet var headView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tableHeaderView = headView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "reuseIdentifier"
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell?
        
        
        // Configure the cell...
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
 
        let row = indexPath.row
        
        
        switch row
        {
        case 0:
            cell!.textLabel?.text = "留学计划"
            
        case 1:
            cell!.textLabel?.text = "我的学校"
        case 2:
            cell!.textLabel?.text = "找课程"
        case 3:
            cell!.textLabel?.text = "找代理"
        case 4:
            cell!.textLabel?.text = "找同学校友"
        case 7:
            cell!.textLabel?.text = "个人信息"
        case 8:
            cell!.textLabel?.text = "登出"
        default:
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            cell?.userInteractionEnabled = false
        }

        return cell!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if DeviceType.IS_IPHONE_5 {
            return 47.3
        } else if DeviceType.IS_IPHONE_6 {
            return 58.4
        } else if DeviceType.IS_IPHONE_6P {
            return 66
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            return 37.6
        } else {
            return 50
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
            let navi = UINavigationController(rootViewController: vc)
            
            navi.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
            navi.navigationBar.tintColor = UIColor.whiteColor()
            navi.navigationBar.barStyle = UIBarStyle.Black
            
            
            self.mm_drawerController.setCenterViewController(navi, withCloseAnimation: true, completion: nil)
            
        case 1:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case 2:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("secondTab") as! SecondTabViewController
            let navi = UINavigationController(rootViewController: vc)
            
            navi.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
            navi.navigationBar.tintColor = UIColor.whiteColor()
            navi.navigationBar.barStyle = UIBarStyle.Black
            
            
            self.mm_drawerController.setCenterViewController(navi, withCloseAnimation: true, completion: nil)
            
        case 3:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case 4:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case 7:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case 8:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        default:
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
}

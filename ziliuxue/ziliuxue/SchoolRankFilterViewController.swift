//
//  SchoolRankFilterViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/24.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

protocol SchoolRankFilterViewControllerDelegate{
    
    func didSelectSubViewWithItem()
    
}


class SchoolRankFilterViewController: BaseViewController,SKSTableViewDelegate {

    var tableView:SKSTableView!
    
    var delegate:SchoolRankFilterViewControllerDelegate!
    
    var dataSource = [["本科生院排名","综合排名","专业排名"],["研究生院排名","综合排名","专业排名"],["文理学院排名","综合排名","专业排名"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableView(){
        self.tableView = SKSTableView(frame: CGRectMake(0,0,300,ScreenSize.SCREEN_HEIGHT))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.SKSTableViewDelegate = self
        
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SKSTableViewCell"
        
        var cell:SKSTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SKSTableViewCell
        
        if nil == cell{
            cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = self.dataSource[indexPath.row][0]
        cell?.textLabel?.textAlignment = NSTextAlignment.Center
        cell?.expandable = true;

        return cell!
    }
    
    
    func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {
        return 2
    }
    
    func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cellIdentifier = "expandSKSTableViewCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if nil == cell{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = self.dataSource[indexPath.row][indexPath.subRow]
        cell?.textLabel?.textAlignment = NSTextAlignment.Center
        
        return cell!
    }

    func tableView(tableView: SKSTableView!, didSelectSubRowAtIndexPath indexPath: NSIndexPath!) {
        
        self.delegate.didSelectSubViewWithItem()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

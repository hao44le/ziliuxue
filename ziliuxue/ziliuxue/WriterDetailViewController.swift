//
//  WriterDetailViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/2/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class WriterDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var backScrollView: UIScrollView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1500)
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "comments"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
     
        return cell!
        
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

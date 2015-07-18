//
//  PopUpViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/29/15.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{

    
    var localFilteredMajorArray : [String] = []
    var MajorArray : [String] = ["商业与经济","工程学","视觉艺术与设计","新闻与传媒","科学与数学"]
    var resultSeachController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.resultSeachController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            controller.searchBar.barTintColor = UIColor(red: 245.0/255, green: 146.0/255, blue: 108.0/255, alpha: 1)
            controller.searchBar.tintColor = UIColor(red: 245, green: 146, blue: 108, alpha: 1)
            controller.searchBar.translucent = false
            //controller.hidesNavigationBarDuringPresentation = true
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        if self.resultSeachController.active {
            cell.textLabel?.text = self.localFilteredMajorArray[indexPath.row]
            
        } else {
            cell.textLabel?.text = self.MajorArray[indexPath.row]
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSeachController.active {
            return localFilteredMajorArray.count
        } else {
             return self.MajorArray.count
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        localFilteredMajorArray.removeAll(keepCapacity: false)
        
        
        //Local search
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchController.searchBar.text)
        let array = (MajorArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.localFilteredMajorArray = array as! [String]
        
        
        
        self.tableView.reloadData()
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

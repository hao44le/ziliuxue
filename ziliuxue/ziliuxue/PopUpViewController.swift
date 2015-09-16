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
    var MajorArray : [String] = ["商业与经济","工程学","视觉艺术与设计","新闻与传媒","科学与数学","计算机科学"]
    var resultSeachController = UISearchController()
    var selectedMajor = ""
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        let navigationBar = UINavigationBar(frame: CGRectMake(0, -40, ScreenSize.SCREEN_WIDTH, 61))
        navigationBar.barTintColor = Utils.mainColor
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.barStyle = UIBarStyle.Black
        
        let navigationItem = UINavigationItem(title: "选择我的专业")
      
        let leftButton = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back_cliked")
        navigationItem.leftBarButtonItem = leftButton
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        self.resultSeachController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            //controller.delegate = self
            controller.searchBar.sizeToFit()
            controller.searchBar.barTintColor = UIColor(red: 249/255, green: 99/255, blue: 50/255, alpha: 0.8)
            controller.searchBar.tintColor = UIColor.whiteColor()
            controller.searchBar.placeholder = "搜索大学专业"
            controller.searchBar.translucent = true
            //controller.searchBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
            //controller.searchBar.delegate = self
            //controller.hidesNavigationBarDuringPresentation = true
            //self.view.addSubview(controller.searchBar)
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()

        // Do any additional setup after loading the view.
    }
    
    func back_cliked(){
        if resultSeachController.active {
            resultSeachController.active = false
            //self.resultSeachController.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
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
        
        if self.resultSeachController.searchBar.text == "" {
            self.localFilteredMajorArray = self.MajorArray
        } else {
            //Local search
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
            let array = (MajorArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.localFilteredMajorArray = array as! [String]
            
            
        }
        
        
        
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if resultSeachController.active {
            self.selectedMajor = self.localFilteredMajorArray[indexPath.row]
            resultSeachController.active = false
             //self.resultSeachController.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
            self.selectedMajor = self.MajorArray[indexPath.row]
        }
        NSNotificationCenter.defaultCenter().postNotificationName("userSelectedMajorChanged", object: nil, userInfo: ["major":self.selectedMajor])
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.resultSeachController.searchBar.resignFirstResponder()
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

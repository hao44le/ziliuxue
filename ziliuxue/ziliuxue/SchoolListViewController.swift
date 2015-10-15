//
//  SchoolListViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 14/10/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class SchoolListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var universityArray : [College] = []
    var collegeDetail : CollegeDetail?
    var selectedUniversity : College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("College", ofType: "plist")
        
        
        
        let data : NSArray = NSArray(contentsOfFile: path!)!
        for school in data {
            let id = school.objectForKey("_id") as! String
            let name = school.objectForKey("name") as! String
            let general = school.objectForKey("general") as! NSDictionary
            
            //ServerMethods.getCollegeDetail(id)
            let website = general.objectForKey("website") as! String
            let logo = name + " logo"
            
            let address = general.objectForKey("address") as! NSDictionary
            let photos = [name + " photo1",name + " photo2",name + " photo3"]
            
            let city = address.objectForKey("city") as! String
            let country = address.objectForKey("country") as! String
            let state = address.objectForKey("state") as! String
            let zipcode = address.objectForKey("zipcode") as! String
            
            let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
            universityArray.append(college)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "success:", name: "getCollegeDetailSuccessed", object: nil)
        // Do any additional setup after loading the view.
        self.navigationItem.title = "我的学校"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "学校", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
    }
    func success(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        print(userInfo.objectForKey("collegeDetail"), terminator: "")
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.universityArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SchoolOverviewTableCell
        cell.universityName.text = self.universityArray[indexPath.row].name
        cell.logo.image = UIImage(named: self.universityArray[indexPath.row].logo)
        cell.logo.layer.cornerRadius = 23
        //cell.universityName.sizeToFit()
        cell.logo.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedUniversity = self.universityArray[indexPath.row]
        Tool.showProgressHUD("正在加载")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let path = NSBundle.mainBundle().pathForResource(self.selectedUniversity?.name, ofType: "plist")
            let data : NSDictionary = NSDictionary(contentsOfFile: path!)!
            self.collegeDetail = Tool.parseJsonAndReturnCollegeDetail(data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                Tool.dismissHUD()
                self.performSegueWithIdentifier("toUniversity", sender: self)
            })
        })
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toUniversity" {
            let tab = segue.destinationViewController as! OverviewSchoolTabViewController
            tab.collegeDetail = self.collegeDetail
            
        }
    }
    
    
    
}

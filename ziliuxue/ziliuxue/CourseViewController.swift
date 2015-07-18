//
//  CourseViewController.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class CourseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    var courseName:String!
    var courseOverViewList:[CourseOverView] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ServerMethods.getCourseOverview(self.courseName)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didGetCourseOverView:"), name: "didGetCourseOverview", object: nil)
        
        //print(self.courseOverViewList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseOverViewList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseTableViewCell", forIndexPath: indexPath) as! CourseTableViewCell
        
        var courseOverView = self.courseOverViewList[indexPath.row] as CourseOverView
        
        cell.teacherImage.sd_setImageWithURL(NSURL(string: courseOverView.teacherPicURL), placeholderImage: nil)
        
        println(courseOverView.teacherPicURL)
        cell.courseImage.sd_setImageWithURL(NSURL(string: courseOverView.coursePicURL), placeholderImage: nil)
        
        cell.coursePrice.text = "￥" + String(courseOverView.price)
        cell.couseName.text = courseOverView.courseName
        
        
        var courseDetail = courseOverView.teacherName + " |"
        courseDetail += courseOverView.location
        courseDetail += " |  ❤️"
        courseDetail += String(courseOverView.favNum)
        
        cell.courseDetail.text = courseDetail
        
    
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.selectedIndex = indexPath.row
        self.performSegueWithIdentifier("fromCourseViewToCourseDetail", sender: self)
    }

    
    func didGetCourseOverView(notification:NSNotification)
    {
        self.courseOverViewList = notification.object as! [CourseOverView]
        Tool.showSuccessHUD("获取成功")
        self.tableView.reloadData()
        

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var courseDetailVC = segue.destinationViewController as! CourseDetailViewController
        
        var courseOverView = self.courseOverViewList[self.selectedIndex]
        courseDetailVC.courseID =
        
    }


}

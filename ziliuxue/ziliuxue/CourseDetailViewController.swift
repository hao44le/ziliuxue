//
//  CourseDetailViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 7/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CourseDetailViewController: UIViewController {

    
    
    
    
    
    
    
    
    
    var courseID : NSString!
    var courseDetail : CourseDetail!
    var metadata : NSDictionary!
    var overview : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didGetCourseDetail:"), name: "didGetCourseDetail", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didGetCourseDetail(notification:NSNotification)
    {
        self.courseDetail = notification.object as! CourseDetail
        Tool.showSuccessHUD("获取成功")
        //self.tableView.reloadData()
        
        
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

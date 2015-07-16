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

    
    
    
    var courseName = ["  2015.1.1-2015.1.31  周六下午 1:00 到 5:00  地点: A","  2015.2.1-2015.2.19  周六下午 12:30 到 4:30  地点: B","  2015.2.25-2015.3.27  周六下午 1:00 到 5:00  地点: C"]
    
    
    var similarCourseTitle = ["  北京阳光TOEFL写作初级班","  北京陈东TOEFL写作初级班"]
    
    var similarCourseDetail = ["   2015.01.28 - 2015.4.15  | 10次课 |  北京海淀区","   2015.03.28 - 2015.5.25  | 12次课 |  北京朝阳区"]
    var image = ["classroom","classroom2","universityBack"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

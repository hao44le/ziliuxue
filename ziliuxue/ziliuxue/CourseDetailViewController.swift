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

class CourseDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate {

    
    
    @IBOutlet var backgroundScrollView: UIScrollView!
    
    @IBOutlet var coursePicScrollView: UIScrollView!
    
    @IBOutlet var teacherPic: UIImageView!
    
    @IBOutlet var courseName: UILabel!
    
    @IBOutlet var coursePrice: UILabel!
    @IBOutlet var favNum: UILabel!
    
    
    @IBOutlet var teacherName: UILabel!
    
    
    @IBOutlet var courseSubTitle: UILabel!
    
    
    @IBOutlet var teacherIntro: UILabel!
    
    @IBOutlet var bookMarkButton: UIButton!
    
    @IBOutlet var sessionScrollView: UIScrollView!
    
    @IBOutlet var sessionName: UILabel!
    
    @IBOutlet var sessionTableView: UITableView!
    
    @IBOutlet var sessionMapView: MKMapView!
    
    @IBOutlet var similarTableView: UITableView!
    
    
    var courseID : String!
    var courseDetail : CourseDetail!
    var metadata : NSDictionary!
    var overview : NSDictionary!
    
    var sessions : NSArray = []
    var selectedSession = 0
    var similarCourses: NSArray = []
    var pinImage = ["pinA","pinB","pinC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didGetCourseDetail:"), name: "didGetCourseDetail", object: nil)
        
        ServerMethods.getCourseDetail(self.courseID)
        
        self.favNum.text = " ❤️" + String(self.metadata.objectForKey("favs") as! NSInteger)
        self.teacherName.text = self.overview.objectForKey("teacher")?.objectForKey("name") as! String!
        self.courseSubTitle.text = self.overview.objectForKey("subtitle") as? String
        self.teacherIntro.text = self.overview.objectForKey("introduction") as? String
        self.coursePrice.text = " ￥" + String(self.metadata.objectForKey("price") as! NSInteger)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didGetCourseDetail(notification:NSNotification)
    {
        self.courseDetail = notification.object as! CourseDetail
        Tool.showSuccessHUD("获取成功")
        
        self.courseName.text = self.courseDetail.name
        
        self.sessions = self.courseDetail.sessions
        
        self.sessionName.text = self.sessions[0]["title"] as! String + "--课程信息"
        
        self.setUpSessionScrollView()
        
        self.sessionTableView.reloadData()
        
        self.setUpSessionMapView()
        self.addAnnotation()
        
    }
    
    
    func setUpSessionScrollView()
    {
        
        
        for i in 0..<self.sessions.count
        {
            
            var session = self.sessions[i] as! NSDictionary
            
            var classes = session.objectForKey("classes") as! NSArray
            var xOffset = DeviceSize.SCREEN_WIDTH * CGFloat(i) / 2
            var titleLabel = UILabel(frame: CGRectMake(10 + CGFloat(xOffset) , 20, 150, 30))
            titleLabel.text = session.objectForKey("title") as? String
            titleLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
            self.sessionScrollView.addSubview(titleLabel)
            
            var dateLabel = UILabel(frame: CGRectMake(10 + CGFloat(xOffset) , 55, 150, 30))
            var date = session.objectForKey("start_date") as! String + "-"
            date += session.objectForKey("end_date") as! String
            dateLabel.text = date
            dateLabel.font = UIFont(name: "Helvetica", size: 10)
            self.sessionScrollView.addSubview(dateLabel)
            
            var enrollStatusLabel = UILabel(frame: CGRectMake(10 + CGFloat(xOffset) , 90, 150, 20))
            var status = "已报" + String(session.objectForKey("enrollment") as! NSInteger)
            status += "人     "
            status += String(session.objectForKey("vacancy") as! NSInteger)
            status += "空位"
            enrollStatusLabel.text = status
            enrollStatusLabel.font = UIFont(name: "Helvetica", size: 16)
            
            self.sessionScrollView.addSubview(enrollStatusLabel)
            
        }
        
    }
    
    func setUpSessionMapView()
    {
        
        var session = self.sessions[0] as! NSDictionary
        
        var classes = session.objectForKey("classes") as! NSArray
        var latitude = (classes[1].objectForKey("geo_location") as! NSDictionary).objectForKey("latitude") as! NSString
        var longitude = (classes[1].objectForKey("geo_location") as! NSDictionary).objectForKey("longitude") as! NSString
        
        var region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue), MKCoordinateSpanMake(0.001, 0.01))
        self.sessionMapView.setRegion(region, animated: true)
    }
    
    func addAnnotation()
    {
        var session = self.sessions[0] as! NSDictionary
        
        var classes = session.objectForKey("classes") as! NSArray
        
        for i in 0..<classes.count{
            var geo_location = classes[i].objectForKey("geo_location") as! NSDictionary
            
            var location = CLLocationCoordinate2DMake((geo_location.objectForKey("latitude") as! NSString).doubleValue, (geo_location.objectForKey("longitude") as! NSString).doubleValue)
            var annotation = CourseAnnotation(coordinate: location, title: session.objectForKey("title") as! String, subtitle: "Shuoaaaa", image:UIImage(named: self.pinImage[i])!)
            
            self.sessionMapView.addAnnotation(annotation)
            
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation.isKindOfClass(CourseAnnotation.classForCoder())
        {
            var identifier = "annotation"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout=true;
                annotationView.calloutOffset=CGPointMake(0, 0);
                annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "coursePin"))
                
            }
            
            annotationView.annotation = annotation
            annotationView.image = (annotation as! CourseAnnotation).image
            
            return annotationView
        }
        else{
            return nil
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == self.sessionTableView{
            
            return self.sessions.count
            
        } else if tableView == self.similarTableView{
        
            return self.similarCourses.count
            
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if tableView == self.sessionTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("SessionTableViewCell", forIndexPath: indexPath) as! SessionTableViewCell
            var session = self.sessions[self.selectedSession] as! NSDictionary
            
            var classes = session.objectForKey("classes") as! NSArray
            
            var singleClass = classes[indexPath.row] as! NSDictionary
            var classDetail = singleClass.objectForKey("start_date") as! String + "-"
            classDetail += singleClass.objectForKey("end_date") as! String
            
            
            cell.sessionDetail.text = classDetail
            
            return cell
        } else if tableView == self.similarTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("SimilarCourseTableViewCell", forIndexPath: indexPath) as! SimilarCourseTableViewCell
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionTableViewCell", forIndexPath: indexPath) as! SessionTableViewCell
        
        return cell
        
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

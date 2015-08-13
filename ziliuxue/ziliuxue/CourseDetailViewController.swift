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

class CourseDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,UIScrollViewDelegate,SwipeViewDelegate, SwipeViewDataSource {

    let kCoursePicScrollViewTag = 2006
    
    @IBOutlet var backgroundScrollView: UIScrollView!
    
    @IBOutlet var coursePicSwipeView: SwipeView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var teacherPic: UIImageView!
    
    @IBOutlet var courseName: UILabel!
    
    @IBOutlet var coursePrice: UILabel!
    
    @IBOutlet var favNum: UILabel!
    
    @IBOutlet var ratingBar: RatingBar!
    
    @IBOutlet var favButton: UIButton!
    
    @IBOutlet var teacherName: UILabel!
    
    @IBOutlet var courseSubTitle: UILabel!
    
    @IBOutlet var teacherIntro: UILabel!
    
    @IBOutlet var bookMarkButton: UIButton!
    
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
        var teacherURL = NSURL(string: ServerConstant.baseURL + ((self.overview["teacher"] as! NSDictionary)["avatar"] as! String))
        //self.teacherPic.sd_setImageWithURL(teacherURL, placeholderImage: nil)
     
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
    }
    
    func didGetCourseDetail(notification:NSNotification)
    {
        self.courseDetail = notification.object as! CourseDetail
        Tool.showSuccessHUD("获取成功")
        
        self.courseName.text = self.courseDetail.name
        
        self.sessions = self.courseDetail.sessions
        
        self.sessionName.text = self.sessions[0]["title"] as! String + "--课程信息"
        
        self.similarCourses = self.courseDetail.similars
     
        self.sessionTableView.reloadData()
        self.similarTableView.reloadData()
        
        self.setUpSessionMapView()
        self.addAnnotation()
        
    }
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 3
    }
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {

        var coursePicImage = UIImageView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 233))
        var urlString = ServerConstant.baseURL + (((self.overview["photos"] as! NSArray)[index]) as! String) as String
        var picURL = NSURL(string: urlString)
        
        coursePicImage.sd_setImageWithURL(picURL, placeholderImage: nil)
        //coursePicImage.image = UIImage(named: "Massachusetts Institute of Technology photo1")
        return coursePicImage
        
    }

    func swipeViewDidScroll(swipeView: SwipeView!) {
        
        self.pageControl.currentPage = swipeView.currentPage
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
            var annotation = CourseAnnotation(coordinate: location, title: session.objectForKey("title") as! String, subtitle: "点击查看详情", image:UIImage(named: self.pinImage[i])!)
            
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
            
            if self.sessions != []
            {
                var session = self.sessions[0] as! NSDictionary
                
                var classes = session.objectForKey("classes") as! NSArray
                return classes.count
            }
            else
            {
                return 0
            }
            
            
            
        } else if tableView == self.similarTableView{
       
            return self.similarCourses.count
            
        }else
        {
            return 0
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if tableView == self.sessionTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("SessionTableViewCell", forIndexPath: indexPath) as! SessionTableViewCell
            var session = self.sessions[self.selectedSession] as! NSDictionary
            
            var classes = session.objectForKey("classes") as! NSArray
  
            var singleClass = classes[indexPath.row] as! NSDictionary
            var classDetail = (singleClass.objectForKey("start_date") as! NSString).substringToIndex(10) + "-"
            classDetail += (singleClass.objectForKey("end_date") as! NSString).substringToIndex(10)
            classDetail += "  "
            classDetail += singleClass.objectForKey("day_of_week") as! String
            classDetail += "  "
            classDetail += singleClass.objectForKey("class_starts_at") as! String
            classDetail += "-"
            classDetail += singleClass.objectForKey("class_ends_at") as! String
            classDetail += "  地点："
            var locationIndex = ["A","B","C"]
            classDetail += locationIndex[indexPath.row] as String
                
            cell.sessionDetail.text = classDetail
        
            
            return cell
        } else if tableView == self.similarTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("SimilarCourseTableViewCell", forIndexPath: indexPath) as! SimilarCourseTableViewCell
            
            var row = indexPath.row
            cell.courseName.text = self.similarCourses[row]["name"] as? String
            cell.courseDetail.text = self.similarCourses[row]["summary"] as? String
            var price = "￥" + String(self.similarCourses[row]["price"] as! Int)
            cell.price.text = price
            var teacherImage = [UIImage(named: "teacher1")!,UIImage(named: "teacher2")!]
            cell.avatarImageView.image = teacherImage[row]

            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("SessionTableViewCell", forIndexPath: indexPath) as! SessionTableViewCell
    
            return cell
        }
        
        
        
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

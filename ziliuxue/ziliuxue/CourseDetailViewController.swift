//
//  CourseDetailViewController.swift
//  
//
//  Created by Gelei Chen on 7/9/15.
//
//

import UIKit
import MapKit
import CoreLocation


class CourseDetailViewController: UIViewController,SwipeViewDataSource,UITableViewDelegate,UITableViewDataSource  {

 
    @IBAction func addToBookmark(sender: UIButton) {
    }

    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var swipeView: SwipeView!
    
    @IBOutlet weak var courseTitle: UILabel!
    
    @IBOutlet weak var numberOfFavoriteLabel: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var teacherExpertise: UILabel!
    @IBOutlet weak var teacherDescription: UITextView!
  
    @IBOutlet weak var similarCourseTableView: UITableView!
    @IBOutlet weak var courseMapView: MKMapView!

    @IBOutlet weak var courseTableView: UITableView!
    
    
    var courseName = ["  2015.1.1-2015.1.31  周六下午 1:00 到 5:00  地点: A","  2015.2.1-2015.2.19  周六下午 12:30 到 4:30  地点: B","  2015.2.25-2015.3.27  周六下午 1:00 到 5:00  地点: C"]
    
    
    var similarCourseTitle = ["  北京阳光TOEFL写作初级班","  北京陈东TOEFL写作初级班"]
    
    var similarCourseDetail = ["   2015.01.28 - 2015.4.15  | 10次课 |  北京海淀区","   2015.03.28 - 2015.5.25  | 12次课 |  北京朝阳区"]
    var image = ["classroom","classroom2","universityBack"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 39.9167, longitude: -116.3833), 5000, 5000)
        self.courseMapView.setRegion(zoomRegion, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: SwipeView
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 3
    }
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        let created = UIView(frame: swipeView.bounds)
        let imageView = UIImageView(frame: created.bounds)
        imageView.image = UIImage(named: image[index])
        created.addSubview(imageView)
        
        return created
    }
    
    func swipeViewItemSize(swipeView: SwipeView!) -> CGSize {
        return self.swipeView.bounds.size
    }
    
    func swipeViewCurrentItemIndexDidChange(swipeView: SwipeView!) {
        self.pageControl.currentPage = swipeView.currentPage
    }

    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == courseTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("courseDetialCell", forIndexPath: indexPath) as! CourseDetailTableViewCell
            cell.leftLabel.text = courseName[indexPath.row]
            return cell
        } else if tableView == similarCourseTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("courseDetialCell", forIndexPath: indexPath) as! SimilarCourseTableViewCell
            cell.courseTitle.text = similarCourseTitle[indexPath.row]
            cell.courseDetail.text = similarCourseDetail[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == courseTableView{
            return courseName.count
        } else if tableView == similarCourseTableView{
            return similarCourseTitle.count
        } else {
            return 1
        }
    }

    /*
    // MARK: - Navigat
    ion

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  NewsUpdateViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit
class NewsUpdateViewController: UIViewController{
//class NewsUpdateViewController: UIViewController,XYPieChartDataSource,XYPieChartDelegate {

    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    @IBOutlet weak var pieView: XYPieChart!
    /*
    var pieChartValue = [CGFloat(1),CGFloat(3)]
    var pieChartColor = [UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1),UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)]
    var slices = [11,8,6,6,6]
    var text = ["经济学","政治学","生物","心理学","公共政策"]
    */
    
    var scrollView: UIScrollView!
    var timeline:   TimelineOverview!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.pieView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.pieView.dataSource = self
        self.pieView.delegate = self
        self.pieView.startPieAngle = CGFloat(M_PI_2)
        self.pieView.animationSpeed = 1.5
        self.pieView.showLabel = true
        self.pieView.labelColor = UIColor.whiteColor()
        self.pieView.labelFont = UIFont.systemFontOfSize(20)
        self.pieView.labelRadius = 100
        self.pieView.showPercentage = false
        self.pieView.pieCenter = CGPointMake(ScreenSize.SCREEN_WIDTH / 2, 0)
        */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timelineOverviewButtonTouched:", name: "timelineOverviewButtonTouched", object: nil)
        
        self.pieView.hidden = true
        
        
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame: view.bounds)
        
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        //scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 60),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -50)
            ])
        
        timeline = TimelineOverview(bulletType: .Circle, TimeOverviewFrames: [
            TimeOverviewFrame(section:[TimelineOverviewSection(detail:"January 1",title:"2011.5.16",time:"New Year's Day")], image: UIImage(named: "fireworks.jpeg")),
            TimeOverviewFrame(section:[TimelineOverviewSection(detail:"January 1",title:"2011.5.16",time:"New Year's Day")], image: UIImage(named: "fireworks.jpeg"))
            ])
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0)
            ])
        
        view.sendSubviewToBack(scrollView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timelineOverviewButtonTouched(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        let selection = userInfo.objectForKey("currentSelection") as! String
        println(selection)
        self.performSegueWithIdentifier("toTimelineDetail", sender: self)
    }
    
    /*
    // MARK: PieChart DataSource
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
    return UInt(self.slices.count)
    }
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
    return self.pieChartColor[Int(index)]
    }
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
    return CGFloat(self.slices[Int(index)])
    }
    func pieChart(pieChart: XYPieChart!, textForSliceAtIndex index: UInt) -> String! {
        return self.text[Int(index)]
    }
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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

class CourseDetailViewController: UIViewController{
    
    
    @IBOutlet weak var backScrollView: UIScrollView!
    
    var courseInfoView:ZLXCourseInfoView!
    var courseFilterView:ZLXCourseFilterView!
    var relatedCourseView:ZLXFixedRowWithSubtitleButtonView!
    var evaluationAndCommentView:ZLXTwoSegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1150)
        self.setupShareButton()
        self.backScrollView.backgroundColor = UIColorFromHexRGB(0xf0f4f7)
        self.courseInfoView = ZLXCourseInfoView(frame: CGRectMake(5, 69, ScreenSize.SCREEN_WIDTH - 10, 160), dataModel: nil)
        self.backScrollView.addSubview(self.courseInfoView)
        
        self.courseFilterView = ZLXCourseFilterView(frame: CGRectMake(5, CGRectGetMaxY(self.courseInfoView.frame) + 5, ScreenSize.SCREEN_WIDTH - 10, 300), array: [["excel"],["excel"],["excel"],["excel"],["excel"],["excel"]])
       
        self.backScrollView.addSubview(self.courseFilterView)
        
        self.relatedCourseView = ZLXFixedRowWithSubtitleButtonView(frame: CGRectMake(5, CGRectGetMaxY(self.courseFilterView.frame) + 5, ScreenSize.SCREEN_WIDTH - 10, 186), array: ["课程一","课程二","课程三"])
        self.relatedCourseView.title.text = "相关课程"
        self.backScrollView.addSubview(self.relatedCourseView)
  
        self.evaluationAndCommentView = ZLXTwoSegmentView(frame: CGRectMake(5, CGRectGetMaxY(self.relatedCourseView.frame) + 5 , ScreenSize.SCREEN_WIDTH - 10, 300))
        self.evaluationAndCommentView.title.text = "综合评价"
        self.backScrollView.addSubview(self.evaluationAndCommentView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupShareButton(){
        let shareButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        shareButton.backgroundColor = UIColor.clearColor()
        shareButton.setImage(UIImage(named: "share_button_normal"), forState: UIControlState.Normal)
        shareButton.setImage(UIImage(named: "share_button_highlighted"), forState: UIControlState.Highlighted)
        //shareButton.addTarget(self, action: Selector(""), forControlEvents: UIControlEvents.TouchUpInside)
        let shareItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem = shareItem
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
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

//
//  NewsUpdateViewController.swift
//
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit
class TimelineDetailViewController: UIViewController{
    
    var scrollView: UIScrollView!
    var timeline : TimelineView!
    var viewTitle : String = ""
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.viewTitle
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame: view.bounds)
        
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        
        timeline = TimelineView(bulletType: .Circle, timeFrames: [
            TimeFrame(detail: "", title: "GPA: 3.8", image: UIImage(named: "fireworks"),time:"2011.5.12"),
            TimeFrame(detail: "智能推荐： 重考，参加TOEFL补习班", title: "TOEFL: 80", image: UIImage(named: "heart"),time:"2011.5.16"),
            TimeFrame(detail: "3月周末TOEFL补习班，完成补习班", title: "注册 “李湘TOEFL补习班”",  image: nil,time:"2011.5.16"),
            TimeFrame(detail: "5月周末TOEFL补习班，完成补习班", title: "注册 “马玉TOEFL补习班”", image: UIImage(named: "april"),time:"2011.9.1"),
            TimeFrame(detail: "智能推荐： 可接受，听力分偏低，建议重考", title: "TOEFL: 98", image: nil,time:"2011.5.16"),
            TimeFrame(detail: "5月周末TOEFL补习班，完成补习班", title: "注册 “TOEFL听力补习班”", image: nil,time:"2011.9.1")
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
    
        
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

//
//  SchoolSepecificTabBarController.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class SchoolSepecificTabBarController: UITabBarController {

    
    var collegeDetail : CollegeDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = Utils.mainColor
        self.tabBar.tintColor = UIColor.whiteColor()
        //print("2")
        let first = self.viewControllers![0] as! OverviewSchoolTabViewController
        first.collegeOverview = self.collegeDetail!.collegeOverview
        first.collegeFinancial = self.collegeDetail!.collegeFinancial
        first.college = self.collegeDetail!.college

        let second = self.viewControllers![1] as! SchoolRankingViewController
        second.collegeRanking = collegeDetail!.collegeRanking
        
        let third = self.viewControllers![2] as! SchoolApplicationViewController
        third.collegeApplication = collegeDetail!.collegeApplying
        
        let fourth = self.viewControllers![3] as! SchoolAcademicViewController
        fourth.collegeAcademic = collegeDetail!.collegeAcademic
        
        let fifth = self.viewControllers![4] as! SchoolCostViewController
        fifth.collegeCost = collegeDetail!.collegeFinancial
        

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

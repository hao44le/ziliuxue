//
//  OverviewSchoolTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class OverviewSchoolTabViewController: UIViewController{

    var universityArray : [College] = []
    var selectedUniversity : College?
    var collegeDetail : CollegeDetail?
    
    override func viewDidLoad() {
        
        let path = NSBundle.mainBundle().pathForResource("College", ofType: "plist")
        
        
        
        let data : NSArray = NSArray(contentsOfFile: path!)!
        for school in data {
            let id = school.objectForKey("_id") as! String
            let name = school.objectForKey("name") as! String
            let general = school.objectForKey("general") as! NSDictionary
            
            //ServerMethods.getCollegeDetail(id)
            let website = general.objectForKey("website") as! String
            let logo = name + " logo"
            
            let address = general.objectForKey("address") as! NSDictionary
            let photos = [name + " photo1",name + " photo2",name + " photo3"]
            
            let city = address.objectForKey("city") as! String
            let country = address.objectForKey("country") as! String
            let state = address.objectForKey("state") as! String
            let zipcode = address.objectForKey("zipcode") as! String
            
            let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
            universityArray.append(college)
        }

        
        let schoolview = SchoolCardView(frame: self.view.frame)
        schoolview.parentVCThatHandlesButtonTouchEvent = self
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 1293+21+13 + 21 + 10)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(schoolview)
        
        self.view = scrollView

    }
    
    
    
    func touch(button:UIButton){
        self.selectedUniversity = self.universityArray[0]
        Tool.showProgressHUD("正在加载")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let path = NSBundle.mainBundle().pathForResource(self.selectedUniversity?.name, ofType: "plist")
            let data : NSDictionary = NSDictionary(contentsOfFile: path!)!
            self.collegeDetail = Tool.parseJsonAndReturnCollegeDetail(data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                Tool.dismissHUD()
                switch button.tag {
                case 0:
                    self.performSegueWithIdentifier("toRanking", sender: self)
                case 1:
                    self.performSegueWithIdentifier("toApplication", sender: self)
                case 2:
                    self.performSegueWithIdentifier("toAcademic", sender: self)
                case 3:
                    self.performSegueWithIdentifier("toCost", sender: self)
                default:
                    break
                }
                
            })
        })
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toRanking" {
            let vc = segue.destinationViewController as! SchoolRankingViewController
            vc.collegeRanking = self.collegeDetail!.collegeRanking
        } else if segue.identifier == "toApplication" {
            let vc = segue.destinationViewController as! SchoolApplicationViewController
            vc.collegeApplication = self.collegeDetail!.collegeApplying
        } else if segue.identifier == "toCost" {
            let vc = segue.destinationViewController as! SchoolCostViewController
            vc.collegeCost = self.collegeDetail!.collegeFinancial
        } else if segue.identifier == "toAcademic" {
            let vc = segue.destinationViewController as! SchoolAcademicViewController
            vc.collegeAcademic = self.collegeDetail!.collegeAcademic
        }
    }
    


    

}

//
//  SecondTabViewController.swift
//
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class SecondTabViewController: UIViewController,MCCardPickerCollectionViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var universityArray : [College] = []
    var collegeDetail : CollegeDetail?
    var selectedUniversity : College?
    let kCellIdentifier = "MCSampleCell"
    let cardViewController = MCCardPickerCollectionViewController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "success:", name: "getCollegeDetailSuccessed", object: nil)
        // Do any additional setup after loading the view.
        self.navigationItem.title = "我的学校"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "学校", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        cardViewController.delegate = self
        cardViewController.collectionView.registerClass(SchoolCardCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        cardViewController.collectionView.backgroundColor = UIColor(red: 236/255, green: 235/255, blue: 235/255, alpha: 1)
        
        cardViewController.presentInViewController(self)
        
        
        self.setupLeftMenuButton()
    }
    func success(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        print(userInfo.objectForKey("collegeDetail"), terminator: "")
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.universityArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SchoolCardCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! SchoolCardCollectionViewCell
        cell.layer.cornerRadius = 5
        
        
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 0.1
        cell.layer.masksToBounds = true
        return cell
    }
    func cardPickerCollectionViewController(cardPickerCollectionViewController: MCCardPickerCollectionViewController!, preparePresentingView presentingView: UIView!, fromSelectedCell cell: UICollectionViewCell!) {
        
        for subView in presentingView.subviews {
            subView.removeFromSuperview()
        }
        let view = SchoolCardView(frame: self.view.frame)
        view.parentVCThatHandlesButtonTouchEvent = self
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = cardPickerCollectionViewController
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 1293+21+13 + 21 + 10)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(view)
        
        presentingView.addSubview(scrollView)
        
    }
    
    
    func touch(button:UIButton){
        print(button.tag)
        self.selectedUniversity = self.universityArray[0]
        Tool.showProgressHUD("正在加载")
        
        let path = NSBundle.mainBundle().pathForResource(self.selectedUniversity?.name, ofType: "plist")
        let data : NSDictionary = NSDictionary(contentsOfFile: path!)!
        self.collegeDetail = Tool.parseJsonAndReturnCollegeDetail(data)
        
        Tool.dismissHUD()
        switch button.tag {
        case 0:
            self.performSegueWithIdentifier("toRanking", sender: self)
        case 1:
            self.performSegueWithIdentifier("toApplication", sender: self)
        case 2:
            self.performSegueWithIdentifier("toAcademic", sender: self)
        default:
            self.performSegueWithIdentifier("toCost", sender: self)
        }
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupLeftMenuButton()
    {
        let image = UIImage(named: "left button")
        let leftDrawerButton = UIButton(frame: CGRectMake(0, 0, 25, 25))
        leftDrawerButton.setBackgroundImage(image, forState: UIControlState.Normal)
        
        leftDrawerButton.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        //        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        //self.cardViewController.dismissButton = leftDrawerButton
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toRanking" {
            let vc = segue.destinationViewController as! SchoolRankingViewController
            vc.collegeRanking = self.collegeDetail!.collegeRanking
            vc.source = "mySchool"
        } else if segue.identifier == "toApplication" {
            let vc = segue.destinationViewController as! SchoolApplicationViewController
            vc.collegeApplication = self.collegeDetail!.collegeApplying
            vc.source = "mySchool"
        } else if segue.identifier == "toCost" {
            let vc = segue.destinationViewController as! SchoolCostViewController
            vc.collegeCost = self.collegeDetail!.collegeFinancial
            vc.source = "mySchool"
        } else if segue.identifier == "toAcademic" {
            let vc = segue.destinationViewController as! SchoolAcademicViewController
            vc.collegeAcademic = self.collegeDetail!.collegeAcademic
            vc.source = "mySchool"
        }
    }
    
    
    
}

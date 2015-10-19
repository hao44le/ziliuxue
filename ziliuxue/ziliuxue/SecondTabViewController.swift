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
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        let cardViewController = MCCardPickerCollectionViewController()
        cardViewController.delegate = self
        cardViewController.collectionView.registerClass(MCSampleCardCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kCellIdentifier)

        cardViewController.presentInViewController(self)
        
        
        self.setupLeftMenuButton()
    }
    func success(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        print(userInfo.objectForKey("collegeDetail"), terminator: "")
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: MCSampleCardCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! MCSampleCardCollectionViewCell
        cell.cardRadius = 4.0
        cell.label.text = "User"
        return cell
    }
    func cardPickerCollectionViewController(cardPickerCollectionViewController: MCCardPickerCollectionViewController!, preparePresentingView presentingView: UIView!, fromSelectedCell cell: UICollectionViewCell!) {
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = cardPickerCollectionViewController
        let button: UIButton = UIButton(type:UIButtonType.Custom)
        button.frame = CGRectMake(20, 900, CGRectGetWidth(self.view.frame) - 40, 30)
        button.setTitle("Choose Me :)", forState: UIControlState.Normal)
        scrollView.addSubview(button)
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(button.frame) + 100)
        presentingView.addSubview(scrollView)
        let blurImage: UIImage = (cell as! MCSampleCardCollectionViewCell).blurImage
        presentingView.layer.contents = blurImage.CGImage

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
        
        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toUniversity" {
            let tab = segue.destinationViewController as! OverviewSchoolTabViewController
            tab.collegeDetail = self.collegeDetail
            
        }
    }
    
    

}

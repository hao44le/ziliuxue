//
//  LeftDrawerTableViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 6/28/15.
//  Copyright © 2015 WangShuo. All rights reserved.
//

import UIKit

class LeftDrawerTableViewController: UITableViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet var headView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "postweChatInfo:", name: "postweChatInfo", object: nil)
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
        self.userImage.layer.borderWidth = 3
        self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.tableView.reloadData()
        tableView(self.tableView, willSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
        tableView(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        /*
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        let imageView = cell!.viewWithTag(1111) as! UIImageView
        let label = cell!.viewWithTag(2222) as! UILabel
        label.textColor = Utils.mainColor
        imageView.image = UIImage(named: "studyPlan")
        */
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tableHeaderView = headView
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let loginWay = NSUserDefaults.standardUserDefaults().objectForKey("loginWay") as? String {
            if loginWay == "weChat" {
                if let imgURL = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userImageUrl") as? String {
                    userImage.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "defaultImage"))
                }
                
                if let nickname = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userNickname") as? String {
                    userName.text = nickname
                }
            } else if loginWay == "ziliuxue" {
                if let nickName = NSUserDefaults.standardUserDefaults().objectForKey("nickName") as? String {
                    userName.text = nickName
                    userImage.image = UIImage(named: "defaultImage")
                }
            }
        }
        
        
        
        
       
       
    }
    func postweChatInfo(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        let nickname = userInfo.objectForKey("nickname") as! String
        let imgUrl = userInfo.objectForKey("imgURL") as! String
        userName.text = nickname
        userImage.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "defaultImage"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tableView.separatorColor = UIColor.clearColor()
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "reuseIdentifier"
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell?
        var imageView:UIImageView = UIImageView()
        
        // Configure the cell...
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
 
        let row = indexPath.row
        
        
        switch row
        {
        case 0:
            cell!.textLabel?.text = "            留学清单"
            imageView =  UIImageView(image: UIImage(named: "studyPlan_"))
            
        case 1:
            cell!.textLabel?.text = "            我的学校"
            imageView =  UIImageView(image: UIImage(named: "mySchool_"))
            
        case 2:
            cell!.textLabel?.text = "            找课程"
            imageView =  UIImageView(image: UIImage(named: "findCourse_"))
            
        case 3:
            cell!.textLabel?.text = "            找服务"
            imageView =  UIImageView(image: UIImage(named: "findService_"))
            
        case 6:
            cell!.textLabel?.text = "            个人信息"
            imageView =  UIImageView(image: UIImage(named: "personalInfo_"))
            
        case 7:
            cell!.textLabel?.text = "            登出"
            imageView =  UIImageView(image: UIImage(named: "logout_"))
            
        default:
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            cell?.userInteractionEnabled = false
        }
        
        if DeviceType.IS_IPHONE_6P {
            imageView.frame = CGRectMake(30, 24, 25, 25)
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            imageView.frame = CGRectMake(30, 5, 25, 25)
        } else if DeviceType.IS_IPHONE_5{
            imageView.frame = CGRectMake(32, 12, 25, 25)
        } else if DeviceType.IS_IPHONE_6 {
            imageView.frame = CGRectMake(32, 19, 25, 25)
        }
        cell!.textLabel?.tag = 2222
        imageView.tag = 1111
        cell?.addSubview(imageView)
        //cell?.imageView?.frame = CGRectMake(0, 0, 20, 20)
        return cell!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if DeviceType.IS_IPHONE_5 {
            return 53
        } else if DeviceType.IS_IPHONE_6 {
            return 68
        } else if DeviceType.IS_IPHONE_6P {
            return 76
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            return 41
        } else {
            return 50
        }
    }
    

    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let imageView = cell!.viewWithTag(1111) as! UIImageView
        let label = cell!.viewWithTag(2222) as! UILabel
        label.textColor = Utils.mainColor
        
        switch indexPath.row {
        case 0:
            imageView.image = UIImage(named: "studyPlan")
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
            let image2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image2.image = UIImage(named: "findCourse_")
            let label2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(2222) as! UILabel
            label2.textColor = UIColor.grayColor()
            
            let image3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image3.image = UIImage(named: "findService_")
            let label3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(2222) as! UILabel
            label3.textColor = UIColor.grayColor()
            
            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image6.image = UIImage(named: "personalInfo_")
            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
            label6.textColor = UIColor.grayColor()
            
            
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
        case 1:
            imageView.image = UIImage(named: "mySchool")
            
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = UIColor.grayColor()
            
            
            let label2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(2222) as! UILabel
            label2.textColor = UIColor.grayColor()
            
            let label3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(2222) as! UILabel
            label3.textColor = UIColor.grayColor()
            
            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
            label6.textColor = UIColor.grayColor()
            
            
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "studyPlan_")
            let image2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image2.image = UIImage(named: "findCourse_")
            let image3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image3.image = UIImage(named: "findService_")
            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image6.image = UIImage(named: "personalInfo_")
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
        case 2:
            imageView.image = UIImage(named: "findCourse")
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = UIColor.grayColor()
            
            
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
            let label3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(2222) as! UILabel
            label3.textColor = UIColor.grayColor()
            
            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
            label6.textColor = UIColor.grayColor()
            
            
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "studyPlan_")
            let image3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image3.image = UIImage(named: "findService_")
            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image6.image = UIImage(named: "personalInfo_")
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
        case 3:
            imageView.image = UIImage(named: "findService")
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = UIColor.grayColor()
            
            
            let label2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(2222) as! UILabel
            label2.textColor = UIColor.grayColor()
            
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
            label6.textColor = UIColor.grayColor()
            
            
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let image2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image2.image = UIImage(named: "findCourse_")
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "studyPlan_")
            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image6.image = UIImage(named: "personalInfo_")
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
        case 6:
            imageView.image = UIImage(named: "personalInfo")
            
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = UIColor.grayColor()
            
            
            let label2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(2222) as! UILabel
            label2.textColor = UIColor.grayColor()
            
            let label3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(2222) as! UILabel
            label3.textColor = UIColor.grayColor()
            
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
            
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let image2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image2.image = UIImage(named: "findCourse_")
            let image3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image3.image = UIImage(named: "findService_")
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "studyPlan_")
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
        case 7:
            imageView.image = UIImage(named: "studyPlan")
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
            let image2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image2.image = UIImage(named: "findCourse_")
            let label2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))!.viewWithTag(2222) as! UILabel
            label2.textColor = UIColor.grayColor()
            
            let image3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image3.image = UIImage(named: "findService_")
            let label3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))!.viewWithTag(2222) as! UILabel
            label3.textColor = UIColor.grayColor()
            
            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image6.image = UIImage(named: "personalInfo_")
            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
            label6.textColor = UIColor.grayColor()
            
            
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
        default:
            break
        }
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        var navi:UINavigationController?
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var vc:UIViewController?
        switch row {
        case 0:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
        case 1:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("secondTab") as! SecondTabViewController
           
        case 2:
            
           vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdTab") as! ThirdTabViewController
            
        case 3:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("fourthTab") as! FourthTabBarViewController
        case 6:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalInfoTab") as! PersonalInfoViewController
            
        case 7:
            LocalStore.setLogout()
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
        default:
            break
        }
        
        navi = UINavigationController(rootViewController: vc!)
        navi!.navigationBar.barTintColor = Utils.mainColor
        navi!.navigationBar.tintColor = UIColor.whiteColor()
        navi!.navigationBar.barStyle = UIBarStyle.Black
        
        self.mm_drawerController.setCenterViewController(navi, withCloseAnimation: true, completion: nil)
    }
}

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
        return 9
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
            cell!.textLabel?.text = "            留学计划"
            imageView =  UIImageView(image: UIImage(named: "studyPlan"))
            
        case 1:
            cell!.textLabel?.text = "            我的学校"
            imageView =  UIImageView(image: UIImage(named: "mySchool"))
            
        case 2:
            cell!.textLabel?.text = "            找课程"
            imageView =  UIImageView(image: UIImage(named: "findCourse"))
            
        case 3:
            cell!.textLabel?.text = "            找服务"
            imageView =  UIImageView(image: UIImage(named: "findRepresentative"))
            
        case 4:
            cell!.textLabel?.text = "            找同学校友"
            imageView =  UIImageView(image: UIImage(named: "findClassmate"))
            
        case 7:
            cell!.textLabel?.text = "            个人信息"
            imageView =  UIImageView(image: UIImage(named: "personalInfo"))
            
        case 8:
            cell!.textLabel?.text = "            登出"
            imageView =  UIImageView(image: UIImage(named: "logout"))
            
        default:
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            cell?.userInteractionEnabled = false
        }
        imageView.frame = CGRectMake(30, 10, 30, 30)
        cell?.addSubview(imageView)
        //cell?.imageView?.frame = CGRectMake(0, 0, 20, 20)
        return cell!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if DeviceType.IS_IPHONE_5 {
            return 47.3
        } else if DeviceType.IS_IPHONE_6 {
            return 58.4
        } else if DeviceType.IS_IPHONE_6P {
            return 66
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            return 37.6
        } else {
            return 50
        }
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
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("fourthTab") as! FourthViewController
        case 4:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("fifthTab") as! FifthTabViewController
        case 7:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalInfoTab") as! PersonalInfoViewController
            
        case 8:
            LocalStore.setLogout()
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
        default:
            break
        }
        
        navi = UINavigationController(rootViewController: vc!)
        navi!.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
        navi!.navigationBar.tintColor = UIColor.whiteColor()
        navi!.navigationBar.barStyle = UIBarStyle.Black
        
        self.mm_drawerController.setCenterViewController(navi, withCloseAnimation: true, completion: nil)
    }
}

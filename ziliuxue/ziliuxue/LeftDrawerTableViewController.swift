//
//  LeftDrawerTableViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 6/28/15.
//  Copyright © 2015 WangShuo. All rights reserved.
//

import UIKit

class LeftDrawerTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet var headView: UIView!
    
    var loginBarrier = LoginBarrier()

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
        
        self.tableView.tableHeaderView = headView
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let loginWay = NSUserDefaults.standardUserDefaults().objectForKey("loginWay") as? String {
            if loginWay == "weChat" {
                if let nickname = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userNickname") as? String {
                    userName.text = nickname
                }
                
                if !NSUserDefaults.standardUserDefaults().boolForKey("selectImageForUserAvatar") {
                    if let imgURL = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userImageUrl") as? String {
                        userImage.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "defaultImage"))
                    }
                }
                
            } else if loginWay == "ziliuxue" {
                if let nickName = NSUserDefaults.standardUserDefaults().objectForKey("nickName") as? String {
                    userName.text = nickName
                    if !NSUserDefaults.standardUserDefaults().boolForKey("selectImageForUserAvatar") {
                        userImage.image = UIImage(named: "defaultImage")
                    }
                    
                }
            }
        }

    }
    
    
    @IBAction func avatarOrNameClicked(sender: AnyObject) {
        
        
        self.loginBarrier.checkLoginAndDoBlock { () -> Void in
            
        }
        
    }
    
    
    @IBAction func imageButtonTouched(sender: UIButton) {
        
        let alertController = UIAlertController(title: "更新头像", message: nil, preferredStyle: .ActionSheet)
        
        let goAction = UIAlertAction(title: "相册", style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(picker, animated: true, completion: nil)
                
            } else {
                Tool.showErrorHUD("无法打开相册")
                //                let delay = 2.0 * Double(NSEC_PER_SEC)
                //                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                //                dispatch_after(time, dispatch_get_main_queue(), {
                //                    alert.dismissAlertView()
                //                })
                
            }
            
        }
        
        alertController.addAction(goAction)
        
        let OKAction = UIAlertAction(title: "相机", style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.Camera) {
                    
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType =
                        UIImagePickerControllerSourceType.Camera
                    imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                    //imagePicker.mediaTypes = [kUTTypeImage as NSString]
                    imagePicker.allowsEditing = true
                    
                    self.presentViewController(imagePicker, animated: true,
                        completion: nil)
            } else {
                Tool.showErrorHUD("无法打开相机")
                //                let alert = AMSmoothAlertView(dropAlertWithTitle: "Sorry!", andText: "Can not open camera", andCancelButton: false, forAlertType: AlertType.Failure)
                //                alert.show()
                //                let delay = 2.0 * Double(NSEC_PER_SEC)
                //                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                //                dispatch_after(time, dispatch_get_main_queue(), {
                //                    alert.dismissAlertView()
                //                })
            }
            
        }
        alertController.addAction(OKAction)
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
            
            
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
        alertController.view.tintColor = UIColor.blackColor()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "selectImageForUserAvatar")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.userImage.contentMode = .ScaleAspectFit
            self.userImage.image = pickedImage
            
        }
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func postweChatInfo(notification:NSNotification){
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "selectImageForUserAvatar")
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
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
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
            cell!.textLabel?.text = "            看排名"
            imageView =  UIImageView(image: UIImage(named: "findCollege_"))
            
        case 1:
            cell!.textLabel?.text = "            我的学校"
            imageView =  UIImageView(image: UIImage(named: "mySchool_"))
//        case 6:
//            cell!.textLabel?.text = "            个人信息"
//            imageView =  UIImageView(image: UIImage(named: "personalInfo_"))
            
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
            imageView.image = UIImage(named: "findCollege")
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
//            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image6.image = UIImage(named: "personalInfo_")
//            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label6.textColor = UIColor.grayColor()
            
            
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
        case 1:
            imageView.image = UIImage(named: "mySchool")
            
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = UIColor.grayColor()
            
            
//            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label6.textColor = UIColor.grayColor()
            
            
            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
            label7.textColor = UIColor.grayColor()
            
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "findCollege_")
            
//            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image6.image = UIImage(named: "personalInfo_")
            
            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image7.image = UIImage(named: "logout_")
            
//        case 6:
//            imageView.image = UIImage(named: "personalInfo")
//            
//            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label0.textColor = UIColor.grayColor()
//            
//            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label1.textColor = UIColor.grayColor()
//            
//            let label7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label7.textColor = UIColor.grayColor()
//            
//            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image1.image = UIImage(named: "mySchool_")
//            
//            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image0.image = UIImage(named: "findCollege_")
//            
//            let image7 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image7.image = UIImage(named: "logout_")
            
        case 7:
            imageView.image = UIImage(named: "studyPlan")
            
            
            let image1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image1.image = UIImage(named: "mySchool_")
            let label1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))!.viewWithTag(2222) as! UILabel
            label1.textColor = UIColor.grayColor()
            
//            let image6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(1111) as! UIImageView
//            image6.image = UIImage(named: "personalInfo_")
//            let label6 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0))!.viewWithTag(2222) as! UILabel
//            label6.textColor = UIColor.grayColor()
            
            let image0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(1111) as! UIImageView
            image0.image = UIImage(named: "findCollege")
            let label0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))!.viewWithTag(2222) as! UILabel
            label0.textColor = Utils.mainColor
            
            
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
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SchoolRankViewController") as! SchoolRankViewController
        case 1:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("secondTab") as! SecondTabViewController
//        case 6:
//            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalInfoTab") as! PersonalInfoViewController
            
        case 7:
            LocalStore.setLogout()
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SchoolRankViewController") as! SchoolRankViewController
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

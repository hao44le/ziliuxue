//
//  PersonalInfoViewController.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class PersonalInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    
    let array = ["你的个人信息","你的账号信息和密码","你的考试信息"]
    let imageArray = ["个人资料","账号密码","考试信息"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topImage.layer.cornerRadius = 40
        
        self.topImage.clipsToBounds = true
        self.topImage.layer.borderWidth = 3
        self.topImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "postweChatInfo:", name: "postweChatInfo", object: nil)
        // Do any additional setup after loading the view.
        self.navigationItem.title = "个人信息"
        
        self.setupLeftMenuButton()
    }
    
    func postweChatInfo(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        let nickname = userInfo.objectForKey("nickname") as! String
        let imgUrl = userInfo.objectForKey("imgURL") as! String
        userName.text = nickname
        topImage.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "defaultImage"))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let loginWay = NSUserDefaults.standardUserDefaults().objectForKey("loginWay") as? String {
            if loginWay == "weChat" {
                if let imgURL = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userImageUrl") as? String {
                    topImage.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "defaultImage"))
                }
                
                if let nickname = NSUserDefaults.standardUserDefaults().objectForKey("weChat_userNickname") as? String {
                    userName.text = nickname
                }
            } else if loginWay == "ziliuxue" {
                if let nickName = NSUserDefaults.standardUserDefaults().objectForKey("nickName") as? String {
                    userName.text = nickName
                    topImage.image = UIImage(named: "defaultImage")
                }
            }
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
        
        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)  as! PersonalInfoTableViewCell
        cell.label.text = self.array[indexPath.row]
        cell.iconImage.image = UIImage(named: imageArray[indexPath.row])
        return cell
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

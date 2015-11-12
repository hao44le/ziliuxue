//
//  SchoolRankViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/22.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,WeChatLoginDelegate{

    @IBOutlet var tableView: UITableView!
    
    var server:FindSchoolServer!
    
    var rankFilterView:SchoolRankFilterView!
    var rankFilterViewIsShown = false
    
    var filterButton:UIButton!
    
    var mandatoryLoginController = MandatoryLoginController()
    var loginBarrier = LoginBarrier()
    
    
    var chineseName = ["普利斯顿大学","哈佛大学","哥伦比亚大学","怪物大学","普度大学","伊利诺伊大学香槟分校","霍格沃茨大学"]
    var englishName = ["Princeton University","Harvard University","Columbia University","Monster University","Purdue University","University of llinois Urbanna-Champaign","Hogwarts University"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "学校综合排名"
        self.setupLeftMenuButton()

        self.filterButton = UIButton(type: UIButtonType.Custom)
        self.filterButton.frame = CGRectMake(0, 0, 75, 44)
        self.filterButton.setTitle("更多排名", forState: UIControlState.Normal)
        self.filterButton.titleLabel!.textColor = UIColor.whiteColor()
        self.filterButton.addTarget(self, action: Selector("filterButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)

        let filterButtonItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = filterButtonItem
        
        
        self.server = FindSchoolServer.sharedInstance
        self.server.querySchoolRankList("", pageSize: "", pageNum: "") { (schoolRankListItem) -> Void in
            //对schoolRankListItem进行操作
        }
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        

//        if !LocalStore.isIntroVisited(){
//            if !LocalStore.isLogined(){
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            } else {
//                //self.performSegueWithIdentifier("toWizard", sender: self)
//            }
//        }
//        if LocalStore.isIntroVisited() {
//            if !LocalStore.isLogined() {
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }
//        }

        //self.performSegueWithIdentifier("toWizard", sender: self)
        
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
    
    func filterButtonClicked(){
        
        if nil == self.rankFilterView{
            self.rankFilterView = SchoolRankFilterView(frame: CGRectMake(0,64 + ScreenSize.SCREEN_HEIGHT,ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT - 64))
            self.view.addSubview(self.rankFilterView)
        }
        
        if self.rankFilterViewIsShown{
            self.filterButton.setTitle("更多排名", forState: UIControlState.Normal)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rankFilterView.frame = CGRectOffset(self.rankFilterView.frame, 0, ScreenSize.SCREEN_HEIGHT)
                
                }, completion: { (completion:Bool) -> Void in
                    
            })
            self.rankFilterViewIsShown = false
        }else{
            self.filterButton.setTitle("取消", forState: UIControlState.Normal)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.rankFilterView.frame = CGRectOffset(self.rankFilterView.frame, 0, -ScreenSize.SCREEN_HEIGHT)
                
                }, completion: { (completion:Bool) -> Void in
                    
            })
            
            self.rankFilterViewIsShown = true
        }
        
        
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            
            return self.chineseName.count
        }else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:SchoolRankCell? = tableView.dequeueReusableCellWithIdentifier("schoolRankCell") as? SchoolRankCell

      
        
        let item = SchoolRankListItem()
        item.schoolChineseName = self.chineseName[indexPath.row]
        item.schoolEnglishName = self.englishName[indexPath.row]
        item.schoolRankNum = String(indexPath.row)
    
        cell?.setCellWithItem(item)
        if tableView == self.tableView{
            
            return cell!
        }else{
            return cell!
        }
 
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        
        if 3 <= self.mandatoryLoginController.getSchoolDetailSeenTimes(){
            
            let loginView = LoginPopView(frame: CGRectMake(0,64,self.view.frame.width,self.view.frame.height - 64))
            loginView.delegate = self
            self.view.addSubview(loginView)
            
        }else{
            let vc = OverviewSchoolTabViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.mandatoryLoginController.addSchoolDetailSeenTimes()
        }
        
        
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    func weChatLoginDidSucceed() {
        
    }
    
    func weChatLoginDidFail() {
        
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

//
//  SchoolRankViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/22.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WYPopoverControllerDelegate,SchoolRankFilterViewControllerDelegate{

    @IBOutlet var tableView: UITableView!
    
    var filterPopOverVC:WYPopoverController!
    
    var chineseName = ["普利斯顿大学","哈佛大学","哥伦比亚大学","怪物大学","普度大学","伊利诺伊大学香槟分校","霍格沃茨大学"]
    var englishName = ["Princeton University","Harvard University","Columbia University","Monster University","Purdue University","University of llinois Urbanna-Champaign","Hogwarts University"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "学校综合排名"
        self.setupLeftMenuButton()

        let filterButton = UIButton(type: UIButtonType.Custom)
        filterButton.frame = CGRectMake(0, 0, 75, 44)
        filterButton.setTitle("更多排名", forState: UIControlState.Normal)
        filterButton.titleLabel!.textColor = UIColor.whiteColor()
        filterButton.addTarget(self, action: Selector("filterButtonClicked:"), forControlEvents: UIControlEvents.TouchUpInside)

        let filterButtonItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = filterButtonItem
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if !LocalStore.isIntroVisited(){
            if !LocalStore.isLogined(){
                self.performSegueWithIdentifier("toLogin", sender: self)
            } else {
                //self.performSegueWithIdentifier("toWizard", sender: self)
            }
        }
        if LocalStore.isIntroVisited() {
            if !LocalStore.isLogined() {
                self.performSegueWithIdentifier("toLogin", sender: self)
            }
        }
        
        
        
        
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
    
    func filterButtonClicked(sender:UIButton){
        if nil != self.filterPopOverVC{
            self.filterPopOverVC.presentPopoverFromRect(CGRectMake(ScreenSize.SCREEN_WIDTH - 40, 10, 300, 40), inView: self.view, permittedArrowDirections: WYPopoverArrowDirection.Any, animated: true)
        }else{
        
        let filterVC = SchoolRankFilterViewController()
        filterVC.preferredContentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT - 64)
        filterVC.title = "排名类型"
        filterVC.delegate = self
        filterVC.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismissFilterView")), animated: true)
//        filterVC.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("finishFilterView")), animated: true)
        filterVC.modalInPopover = false
        
        let contentVC = UINavigationController(rootViewController: filterVC)
        
        self.filterPopOverVC = WYPopoverController(contentViewController: contentVC)
        self.filterPopOverVC.delegate = self
        self.filterPopOverVC.passthroughViews = [sender]
        self.filterPopOverVC.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10)
        self.filterPopOverVC.wantsDefaultContentAppearance = false
        
        self.filterPopOverVC.presentPopoverFromRect(CGRectMake(ScreenSize.SCREEN_WIDTH - 40, 10, 300, 40), inView: self.view, permittedArrowDirections: WYPopoverArrowDirection.Any, animated: true)
            
        }
        
    }
    
    func dismissFilterView(){
        
        self.filterPopOverVC.dismissPopoverAnimated(true) { () -> Void in
            self.filterPopOverVC.dismissPopoverAnimated(true)
        }
        
    }
    
//    func finishFilterView(){
//        
//        
//        self.dismissFilterView()
//    }
    
    func didSelectSubViewWithItem() {
        self.dismissFilterView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chineseName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SchoolRankCell? = tableView.dequeueReusableCellWithIdentifier("schoolRankCell") as? SchoolRankCell

        
        cell?.rankNumLabel.text = String(indexPath.row)
        cell?.schoolChineseNameLabel.text = self.chineseName[indexPath.row]
        cell?.schoolEngNameLabel.text = self.englishName[indexPath.row]
        
        if tableView == self.tableView{
            
            return cell!
        }else{
            return cell!
        }
 
    }

    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = SchoolRankFilterViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

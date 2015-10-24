//
//  SchoolRankViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/22.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var tableView: UITableView!
    
    var chineseName = ["普利斯顿大学","哈佛大学","哥伦比亚大学","怪物大学","普度大学","伊利诺伊大学香槟分校","霍格沃茨大学"]
    var englishName = ["Princeton University","Harvard University","Columbia University","Monster University","Purdue University","University of llinois Urbanna-Champaign","Hogwarts University"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "学校综合排名"
        self.setupLeftMenuButton()
        
        let filterButtonItem = UIBarButtonItem(title: "更多排名", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("filterButtonClicked"))
        self.navigationItem.rightBarButtonItem = filterButtonItem
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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

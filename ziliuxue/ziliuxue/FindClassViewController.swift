//
//  FindClassViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/11.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class FindClassViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    var category = ["SAT","GRE","TOEFL","IELTS","GMAT"]
    var picPrefix = "courses_step1_"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLeftMenuButton()
        // Do any additional setup after loading the view.
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("findClassCell") as! FindClassTableViewCell
        
        cell.categoryNameLabel.text = self.category[indexPath.row]
        cell.categoryNameLabel.shadowColor = UIColorFromHexRGB(0x000000)
        cell.backgroundImage.image = UIImage(named: self.picPrefix + self.category[indexPath.row])
        cell.introLabel.text = "美国研究生入学考试资格考试"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let courseFilterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CourseFilterViewController") as! CourseFilterViewController
        courseFilterVC.title = self.category[indexPath.row]
        self.navigationController?.pushViewController(courseFilterVC, animated: true)
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

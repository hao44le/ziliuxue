//
//  SecondTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class SecondTabViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var universityName = ["7","12","15","Harvard University","Stanford University"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "success:", name: "getCollegeDetailSuccessed", object: nil)
        // Do any additional setup after loading the view.
        self.navigationItem.title = "我的学校"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "学校", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        

        self.setupLeftMenuButton()
    }
    func success(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        print(userInfo.objectForKey("collegeDetail"))
        
        
    }
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.universityName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ThirdWizardTableViewCell
        cell.universityName.text = self.universityName[indexPath.row]
        cell.logo.image = UIImage(named: self.universityName[indexPath.row])
        cell.logo.layer.cornerRadius = 30
        cell.logo.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toUniversity", sender: self)
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

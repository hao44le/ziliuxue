//
//  DrawerViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 6/28/15.
//  Copyright © 2015 WangShuo. All rights reserved.
//

import UIKit

class CenterTabViewController: UITabBarController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ServerMethods.getCollege("1", to: "20")
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "留学计划"
        
        self.tabBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
        self.tabBar.tintColor = UIColor.whiteColor()
        self.setupLeftMenuButton()
        
        self.navigationItem.backBarButtonItem = nil
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if !LocalStore.isIntroVisited(){
            if !LocalStore.isLogined(){
                self.performSegueWithIdentifier("toLogin", sender: self)
            } else {
                self.performSegueWithIdentifier("toWizard", sender: self)
            }
        }
        if LocalStore.isIntroVisited() {
            if !LocalStore.isLogined() {
                self.performSegueWithIdentifier("toLogin", sender: self)
            }
        }
        
        
        self.performSegueWithIdentifier("toWizard", sender: self)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

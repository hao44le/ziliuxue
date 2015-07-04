//
//  ViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 6/28/15.
//  Copyright © 2015 WangShuo. All rights reserved.
//

import UIKit

let kMaximumLeftDrawerWidth:CGFloat = 260.0

class ViewController: UIViewController {

    var drawerController:MMDrawerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func enterDrawer(sender: AnyObject) {
        
        let leftSideDrawerViewController:LeftDrawerTableViewController = LeftDrawerTableViewController(nibName: "LeftDrawerTableViewController", bundle: nil)
        
        let centerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
       
        
        let navigationController = UINavigationController(rootViewController: centerViewController)
        
        navigationController.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
        //navigationController.navigationBar.tintColor = UIColor.whiteColor()
        //navigationController.navigationBar.barStyle = UIBarStyle.Black
        
        drawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideDrawerViewController)
        
        
        drawerController.setMaximumLeftDrawerWidth(kMaximumLeftDrawerWidth, animated:false, completion: nil)
        
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        self.presentViewController(drawerController, animated: true, completion: nil)
 

    }
    

}


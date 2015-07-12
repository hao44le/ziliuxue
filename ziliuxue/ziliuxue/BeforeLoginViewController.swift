//
//  BeforeLoginViewController.swift
//  
//
//  Created by Gelei Chen on 7/12/15.
//
//

import UIKit

class BeforeLoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    @IBAction func signupClicked(sender: AnyObject) {
        
        //performSegueWithIdentifier("toView", sender: self)
        
    }
    
    
    @IBAction func loginClicked(sender: UIButton) {
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "自留学", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        loginButton.layer.cornerRadius = 25
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
    }
    
    

}

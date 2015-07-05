//
//  ViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    var email:UITextField = UITextField()
    var password:UITextField = UITextField()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let name = ["电子邮件","密码"]
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func loginClicked(sender: UIButton) {
        //println(email.text)
        //println(password.text)
        
        if email.text == "" {
            let ac = UIAlertView(title: "请输入邮箱", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
        } else if password.text == "" {
            let ac = UIAlertView(title: "请输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
        } else {
            //let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            self.activityIndicator.startAnimating()
            //dispatch_async(dispatch_get_global_queue(priority, 0)){ () -> Void in
        
                ServerMethods.obtainToken(self.email.text!, password: self.password.text!)
                //dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    //self.activityIndicator.stopAnimating()
                    
                    
                    
                    
                    
                    
               // }
           // }
            
            
        }
        
        
        
        
    }

    @IBAction func weiboClicked(sender: UIButton) {
    }

    @IBAction func weChatClicked(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccessed", name: "loginSuccessed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginFailed", name: "loginFailed", object: nil)
        
        
        //self.activityIndicator.startAnimating()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginSuccessed(){
        LocalStore.setLogined()
        self.activityIndicator.stopAnimating()
        self.performSegueWithIdentifier("loginToMain", sender: self)
    }
    func loginFailed(){
        let ac = UIAlertView(title: "账号密码不正确", message: nil, delegate: nil, cancelButtonTitle: "好的")
        ac.show()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
            cell.label.text = self.name[indexPath.row]
        
        if indexPath.row == 0 {
            
            email = cell.textField
        } else {
            cell.textField.secureTextEntry = true
            password = cell.textField
        }
            return cell
       
        
    }
    
    
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


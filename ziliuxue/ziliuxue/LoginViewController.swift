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
    
    @IBOutlet weak var wechatLogoToTopLayoutGuideConstriant: NSLayoutConstraint!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
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
            //self.activityIndicator.startAnimating()
            Tool.showProgressHUD("正在验证")
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
        Tool.showProgressHUD("正在验证")
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "123"
        WXApi.sendReq(req)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.navigationController!.interactivePopGestureRecognizer.delegate = self
        
        
        self.navigationController?.navigationBar.hidden = false
        
               NSNotificationCenter.defaultCenter().addObserver(self, selector: "weChat_login_Successed", name: "weChat_login_Successed", object: nil)
        
        
        
        wechatButton.layer.cornerRadius = 20
        wechatButton.layer.borderWidth = 1
        wechatButton.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        
        
        weiboButton.layer.cornerRadius = 20
        weiboButton.layer.borderWidth = 1
        weiboButton.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        
        
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        


        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccessed", name: "loginSuccessed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginFailed", name: "loginFailed", object: nil)
        
        
        //self.activityIndicator.startAnimating()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func weChat_login_Successed(){
        Tool.dismissHUD()
        LocalStore.setLogined()
        self.performSegueWithIdentifier("loginToMain", sender: self)
    }
    
    
    func loginSuccessed(){
        LocalStore.setLogined()
        //self.activityIndicator.stopAnimating()
        Tool.dismissHUD()
        self.performSegueWithIdentifier("loginToMain", sender: self)
    }
    func loginFailed(){
        Tool.dismissHUD()
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


//
//  ViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {


    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    
    @IBOutlet weak var weChatImage: UIImageView!
    @IBOutlet weak var weiboImage: UIImageView!
   
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var passwordView: UIView!
    let name = ["电子邮件","密码"]
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @IBAction func loginClicked(sender: UIButton) {
        //println(email.text)
        //println(password.text)
        
        if emailTextField.text == "" {
            let ac = UIAlertView(title: "请输入邮箱", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
        } else if passwordTextField.text == "" {
            let ac = UIAlertView(title: "请输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
        } else {
            //let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            //self.activityIndicator.startAnimating()
            Tool.showProgressHUD("正在验证")
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            //dispatch_async(dispatch_get_global_queue(priority, 0)){ () -> Void in
        
                ServerMethods.obtainToken(self.emailTextField.text!, password: self.passwordTextField.text!)
                //dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    //self.activityIndicator.stopAnimating()
                    
                    
                    
                    
                    
                    
               // }
           // }
            
            
        }
        
        
        
        
    }


    @IBAction func weiboClicked(sender: UIButton) {
    }

    @IBAction func weChatClicked(sender: UIButton) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        Tool.showProgressHUD("正在验证")
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "123"
        WXApi.sendReq(req)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 150
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordLabel.hidden = true
        self.passwordTextField.hidden = true
        self.passwordView.hidden = true
        self.loginButton.hidden = true
        //self.navigationController!.interactivePopGestureRecognizer.delegate = self
       
        self.navigationController?.navigationBar.hidden = false
        
               NSNotificationCenter.defaultCenter().addObserver(self, selector: "weChat_login_Successed", name: "weChat_login_Successed", object: nil)
        
        
        
        wechatButton.layer.cornerRadius = 25
        wechatButton.layer.borderWidth = 1
        wechatButton.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        
        
        weiboButton.layer.cornerRadius = 25
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
        NSUserDefaults.standardUserDefaults().setObject("weChat", forKey: "loginWay")
        
        Tool.dismissHUD()
        LocalStore.setLogined()
        self.performSegueWithIdentifier("loginToMain", sender: self)
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    func loginSuccessed(){
        NSUserDefaults.standardUserDefaults().setObject("ziliuxue", forKey: "loginWay")
        
        NSUserDefaults.standardUserDefaults().setObject(emailTextField.text, forKey: "nickName")
        LocalStore.setLogined()
        //self.activityIndicator.stopAnimating()
        Tool.dismissHUD()
        self.performSegueWithIdentifier("loginToMain", sender: self)
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    func loginFailed(){
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        Tool.dismissHUD()
        let ac = UIAlertView(title: "账号密码不正确", message: nil, delegate: nil, cancelButtonTitle: "好的")
        ac.show()
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                //self.view.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
                
                self.weiboImage.hidden = false
                self.weChatImage.hidden = false
                self.weiboButton.hidden = false
                self.wechatButton.hidden = false
                self.hintLabel.hidden = false
                
                if self.emailTextField.text == "" {
                    self.passwordTextField.hidden = true
                    self.passwordLabel.hidden = true
                    self.passwordView.hidden = true
                    self.loginButton.hidden = true
                }
                
            })
        
        
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == emailTextField {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                //self.view.frame = CGRectMake(0, -210, ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
                
                self.hintLabel.hidden = true
                self.weiboImage.hidden = true
                self.weChatImage.hidden = true
                self.weiboButton.hidden = true
                self.wechatButton.hidden = true
                self.passwordLabel.hidden = false
                self.passwordTextField.hidden = false
                self.passwordView.hidden = false
                self.loginButton.hidden = false
            })
        } else {
            
        }
        
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


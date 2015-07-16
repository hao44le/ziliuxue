//
//  SignUpViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/21/15.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var email:UITextField = UITextField()
    var password:UITextField = UITextField()
    var name:UITextField = UITextField()
    var repeated_password:UITextField = UITextField()
    let field = ["名字","电子邮件","密码","重输密码"]
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBAction func signupClicked(sender: UIButton) {
        
        
        //error checking
        if email.text == "" {
            let ac = UIAlertView(title: "请输入邮箱", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        if password.text == "" {
            let ac = UIAlertView(title: "请输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        if name.text == "" {
            let ac = UIAlertView(title: "请输入名字", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        if repeated_password.text == "" {
            let ac = UIAlertView(title: "请再次输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        if password.text != repeated_password.text {
            let ac = UIAlertView(title: "两次密码不相同", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        if email.text.lowercaseString.rangeOfString("@") == nil {
            let ac = UIAlertView(title: "邮箱输入不合法", message: nil, delegate: nil, cancelButtonTitle: "好的")
            ac.show()
            return
        }
        
        //signup
        
        Tool.showProgressHUD("正在注册")
        ServerMethods.signup(email.text, password: password.text,email:"")
        
        
        
    }
    
    func signupSuccessed(){
        ServerMethods.obtainToken(self.email.text!, password: self.password.text!)
        LocalStore.setLogined()
        //self.activityIndicator.stopAnimating()
        Tool.dismissHUD()
        self.performSegueWithIdentifier("signupToMain", sender: self)
    }
    func signupFailed(){
        let ac = UIAlertView(title: "注册失败，请再试一次", message: nil, delegate: nil, cancelButtonTitle: "好的")
        ac.show()
        Tool.dismissHUD()
    }
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        email.resignFirstResponder()
        password.resignFirstResponder()
        name.resignFirstResponder()
        repeated_password.resignFirstResponder()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController!.interactivePopGestureRecognizer.delegate = self
       self.navigationController?.navigationBar.hidden = false
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupSuccessed", name: "signupSuccessed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupFailed", name: "signupFailed", object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.label.text = field[indexPath.row]
        switch indexPath.row {
        case 0 :
            name = cell.textField
        case 1:
             email = cell.textField
        case 2:
            cell.textField.secureTextEntry = true
            password = cell.textField
            
        case 3:
            cell.textField.secureTextEntry = true
            repeated_password = cell.textField
        default:
            break
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return field.count
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

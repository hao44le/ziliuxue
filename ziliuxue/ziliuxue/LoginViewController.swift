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
    
    
    let name = ["电子邮件","密码"]
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
       email.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func loginClicked(sender: UIButton) {
        //println(email.text)
        //println(password.text)
    }

    @IBAction func weiboClicked(sender: UIButton) {
    }

    @IBAction func weChatClicked(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //signup("hao44le", password: "123")
        //obtainToken("hao44le", password: "123")
        //getAllUsers()
        //obtainNewToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTU4ZGYyNTkyN2RhZWE4NjA2ZmZkOGQ0IiwidXNlcm5hbWUiOiJoYW80NGxlIiwiY2xpZW50X2lkIjoiYzA1MGMyYzEtM2FjMC00NmM3LWFiZjYtZTdlZGZiMTZhZWU0IiwidHlwZSI6InJlZnJlc2giLCJpYXQiOjE0MzUzNjYwODB9.RrGMpa5WBOVgGxyyogNQWFSHSWZIe7fyvqgA8E-xWII")
        getCollege("1", to: "3")
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func signup(username:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"username",password,"password")
        manager.POST(ServerConstant.signup, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            print("success")
            
            print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
                print(error)
        }
        
    }
    
    func getAllUsers(){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTU4ZGYyNTkyN2RhZWE4NjA2ZmZkOGQ0IiwidXNlcm5hbWUiOiJoYW80NGxlIiwiY2xpZW50X2lkIjoiYzA1MGMyYzEtM2FjMC00NmM3LWFiZjYtZTdlZGZiMTZhZWU0IiwidHlwZSI6Imp3dCIsImlhdCI6MTQzNTM2NjA4MCwiZXhwIjoxNDM1OTcwODgwfQ.Xa7lLGuHGY-eOo8fD-JqKZnF46a1qHlJxZ8Cr2DzrjU", forHTTPHeaderField: "x-access-token")
        
        manager.GET(ServerConstant.get_user, parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            print("success")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
        }
    }
    
    
    func getCorrectBreakPoint(from:String,to:String)->String{
        return ServerConstant.get_college + from + "&num=" + to
    }
    
    func getCollege(from:String,to:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTU4ZGYyNTkyN2RhZWE4NjA2ZmZkOGQ0IiwidXNlcm5hbWUiOiJoYW80NGxlIiwiY2xpZW50X2lkIjoiYzA1MGMyYzEtM2FjMC00NmM3LWFiZjYtZTdlZGZiMTZhZWU0IiwidHlwZSI6Imp3dCIsImlhdCI6MTQzNTM3MDE2MCwiZXhwIjoxNDM1OTc0OTYwfQ.WdBCfOg1WUfbMSliID8gOSjTDiCJEubJcPoocnYKKfg", forHTTPHeaderField: "x-access-token")
        
        manager.GET(getCorrectBreakPoint(from, to: to), parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            print("success")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
                print(error)
        }

    }
    
    func obtainNewToken(refresh_token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",refresh_token,"refresh_token")
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            print("success")
            
            print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
                print(error)
        }
    }
    
    func obtainToken(username:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"username",password,"password")
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            print("success")
            
            print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
                print(error)
        }
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


//
//  SignUpViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/21/15.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var email:UITextField = UITextField()
    var password:UITextField = UITextField()
    var name:UITextField = UITextField()
    var repeated_password:UITextField = UITextField()
    let field = ["名字","电子邮件","密码","重输密码"]
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        email.resignFirstResponder()
        password.resignFirstResponder()
        name.resignFirstResponder()
        repeated_password.resignFirstResponder()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            password = cell.textField
        case 3:
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

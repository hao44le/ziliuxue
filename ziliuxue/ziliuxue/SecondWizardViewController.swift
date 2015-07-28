//
//  SecondWizardViewController.swift
//  
//
//  Created by Gelei Chen on 6/23/15.
//
//

import UIKit

class SecondWizardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var continueButton: UIButton!
    var name : [String] = []
    
    
    var gpa:UITextField = UITextField()
    var sat:UITextField = UITextField()
    var toefl : UITextField = UITextField()
    var gre : UITextField = UITextField()
    var gmat : UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "情况", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderWidth = 0.5
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
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
        cell.label?.text = name[indexPath.row]
        if indexPath.row == 0 {
            gpa = cell.textField
            gpa.placeholder = "x.x / 平均学术成绩满分4.0"
        } else if indexPath.row == 1 {
            toefl = cell.textField
            toefl.placeholder = "xxx / 满分120"
        } else {
            if name[2] == "SAT" {
                sat = cell.textField
                sat.placeholder = "xxxx / 满分2400"
            } else if name[2] == "GMAT" {
                gmat = cell.textField
                gmat.placeholder = "xxx / 满分800"
            } else {
                gre = cell.textField
                gre.placeholder = "xxx / 满分346"
            }
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toThirdWizard" {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(gpa.text, forKey: "userGPA")
            defaults.setObject(sat.text, forKey: "userSAT")
            defaults.setObject(toefl.text, forKey: "userTOEFL")
            defaults.setObject(gre.text, forKey: "userGRE")
            defaults.setObject(gmat.text, forKey: "userGMAT")
        }
    }
    

}

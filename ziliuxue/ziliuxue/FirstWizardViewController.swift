//
//  ViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class FirstWizardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var continueButton: UIButton!
    let name = ["国家","目标学位","目标专业方向"]
    var detail = ["美国 ","硕士研究生","计算机"]
    var selectedCountry = "美国"
    var selectedDegree = "硕士研究生"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderWidth = 0.5
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.tableView.separatorColor = UIColor.clearColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FirstWizardTableViewCell
        cell.firstLabel?.text = self.name[indexPath.row]
        cell.secondLabel?.text = self.detail[indexPath.row]
    
        return cell
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
           
            MMPickerView.showPickerViewInView(self.view, withStrings: ["美国","加拿大"], withOptions: [MMbackgroundColor:UIColor.whiteColor(),MMbuttonColor:UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1),MMselectedObject:selectedCountry,"height":260], completion: { (selected:String!) -> Void in
                self.selectedCountry = selected
                self.detail[0] = selected
                self.tableView.reloadData()
            })
           
        case 1:
            MMPickerView.showPickerViewInView(self.view, withStrings: ["本科","硕士研究生","博士研究生","工商管理硕士"], withOptions: [MMbackgroundColor:UIColor.whiteColor(),MMbuttonColor:UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1),MMselectedObject:selectedDegree,"height":260], completion: { (selected:String!) -> Void in
                self.selectedDegree = selected
                self.detail[1] = selected
                self.tableView.reloadData()
            })
        case 2:
            self.performSegueWithIdentifier("toPopup", sender: self)
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPopup"{

            let popupSegue = segue as! CCMPopupSegue
            
            
            popupSegue.destinationBounds = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH-60, ScreenSize.SCREEN_HEIGHT - 120)
            popupSegue.backgroundBlurRadius = 7
            popupSegue.backgroundViewAlpha = 0.3
            popupSegue.backgroundViewColor = UIColor.blackColor()
            popupSegue.dismissableByTouchingBackground = true
            
        }
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


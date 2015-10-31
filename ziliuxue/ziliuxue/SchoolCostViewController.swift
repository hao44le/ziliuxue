//
//  SchoolCostViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolCostViewController: UIViewController,UITableViewDataSource {

    let header = ["花费","赞助"]
    let leftForSpending = ["学费","住宿费","预估的书本费","预估的个人花销"]
    let leftForScholarship = ["平均基于需要的奖学金","学生收到基于需要的奖学金比例"]
    var rightForSpeding : [String] = ["","","",""]
    var rightForScholarship : [String] = ["",""]
    
    var source = ""
    
    var collegeCost : CollegeFinancial? {
        didSet{
            self.rightForSpeding[0] = collegeCost!.tuition_and_fees
            self.rightForSpeding[1] = collegeCost!.room_and_board
            self.rightForSpeding[2] = collegeCost!.estimated_cost_of_books_and_supplies
            self.rightForSpeding[3] = collegeCost!.estimated_personal_expenses
            self.rightForScholarship[0] = collegeCost!.average_need_based_scholarship
            self.rightForScholarship[1] = collegeCost!.students_who_received_need_based_scholarship
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if source == "mySchool" {
            let dismissButton = UIButton(type:UIButtonType.Custom)
            dismissButton.frame = CGRectMake(10, 30, 25, 25)
            
            dismissButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
            dismissButton.setImage(UIImage(named:"return"), forState: UIControlState.Normal)
            self.view.addSubview(dismissButton)
            
            
            let titleLabel = UILabel(frame: CGRectMake(15, 30, self.view.frame.width - 30, 25))
            titleLabel.text = "花费及赞助"
            titleLabel.textAlignment = NSTextAlignment.Center
            self.view.addSubview(titleLabel)

            
        }
        self.navigationItem.title = "花费及赞助"
        // Do any additional setup after loading the view.
    }
    func back(){
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if source == "mySchool"{
            return true
        }
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return leftForSpending.count
        } else {
            return leftForScholarship.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if(indexPath.row % 2 == 0){
            cell.contentView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.textLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.detailTextLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = leftForSpending[indexPath.row]
            cell.detailTextLabel?.text = rightForSpeding[indexPath.row]
        } else {
            cell.textLabel?.text = leftForScholarship[indexPath.row]
            cell.detailTextLabel?.text = rightForScholarship[indexPath.row]
        }
        
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "花费"
        } else {
            return "赞助"
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 60))
        let label = UILabel(frame: CGRectMake(0, 0, 60, 60))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = true
        headerView.addSubview(label)
        //label.text = "1"
        
        label.text = header[section]
        return label
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
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

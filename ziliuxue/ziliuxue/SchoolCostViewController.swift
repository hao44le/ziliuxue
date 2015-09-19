//
//  SchoolCostViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolCostViewController: UIViewController,UITableViewDataSource {

    let left = ["学费","住宿费","预估的书本费","预估的个人花销","平均基于需要的奖学金","学生收到基于需要的奖学金比例"]
    var right : [String] = ["","","","","",""]
    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    
    
    
    var collegeCost : CollegeFinancial? {
        didSet{
            self.right[0] = collegeCost!.tuition_and_fees
            self.right[1] = collegeCost!.room_and_board
            self.right[2] = collegeCost!.estimated_cost_of_books_and_supplies
            self.right[3] = collegeCost!.estimated_personal_expenses
            self.right[4] = collegeCost!.average_need_based_scholarship
            self.right[5] = collegeCost!.students_who_received_need_based_scholarship
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return left.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        cell.textLabel?.text = left[indexPath.row]
        cell.detailTextLabel?.text = right[indexPath.row]
        return cell
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

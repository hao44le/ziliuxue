//
//  SchoolApplicationViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolApplicationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var applicationDescription: UILabel!
    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    var applicationDescriptionString = "学生与教师的比例在普渡斯顿大学是6:1，学校有70.9%的班只有不到20名学生。在普林斯顿大学最受欢迎的专业包括：经济学，政治学及政府，分子生物学，心理学与公共政策分析。平均大一保留率：98.3%"
    
    var applicationLeft = ["基本教育","毕业课程要求","课程大学"]
    var applicationRight = ["是","7","人类学，数学，英语，外语，理科，历史，社会科学"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
        applicationDescription.text = applicationDescriptionString
        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicationLeft.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sepecificApplicationCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
        cell.leftLabel.text = applicationLeft[indexPath.row]
        cell.rightLabel.text = applicationRight[indexPath.row]
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

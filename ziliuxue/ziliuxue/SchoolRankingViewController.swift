//
//  SchoolRankingViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolRankingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var rankingLeft = ["分数","高中平均GPA","平均新生保持率","<20学生的课","<50学生的课","学生老师比例","2013秋季接受率","6年毕业率","毕业率预期"]
    var rankingRight = ["100","4.9(5)","98%","70.9%","11%","6:1","7.4%","97%","94%"]
    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
 
    @IBAction func swipeLeft(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
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
        return rankingLeft.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sepecifcRankingCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
        cell.leftLabel.text = rankingLeft[indexPath.row]
        cell.rightLabel.text = rankingRight[indexPath.row]
        if DeviceType.IS_IPHONE_6{
            cell.firstLabelWidth.constant = 187
        } else if DeviceType.IS_IPHONE_6P{
            cell.firstLabelWidth.constant = 205
        }
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

//
//  FindClassViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/11.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class FindClassViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    var category = ["SAT","GRE","TOEFL","IELTS","GMAT"]
    var picPrefix = "courses_step1_"
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("findClassCell") as! FindClassTableViewCell
        
        cell.categoryNameLabel.text = self.category[indexPath.row]
        cell.categoryNameLabel.shadowColor = UIColorFromHexRGB(0x000000)
        cell.backgroundImage.image = UIImage(named: self.picPrefix + self.category[indexPath.row])
        cell.introLabel.text = "美国研究生入学考试资格考试"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let courseFilterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CourseFilterViewController") as! CourseFilterViewController
        courseFilterVC.title = self.category[indexPath.row]
        self.navigationController?.pushViewController(courseFilterVC, animated: true)
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

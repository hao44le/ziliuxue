//
//  StudyPlanViewController.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class StudyPlanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let name = ["TOEFL","GRE","论文","推荐信"]
    let detailTextView = ["满分120， 最低要求90\n" + "你最高分数105\n" + "满足5/5学校要求","满分1200， 最低要求900\n" + "你最高分数950\n" + "满足2/5学校要求","3校要求1篇，2校2篇\n" + "你目前无","3校要求2封，2校3封\n" + "你目前无"]
    let first = [1]
    let second = [40,60]
    let third = [0]
    let fourth = [0]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
       
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FirstTabTableViewCell
        cell.title.text = name[indexPath.row]
        cell.detailTextView.text = detailTextView[indexPath.row]
  
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("1")
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

//
//  PlanOverviewViewController.swift
//  
//
//  Created by Gelei Chen on 7/28/15.
//
//

import UIKit

class PlanOverviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var list : [String] = [""]
    var topName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.topName
        self.navigationController?.navigationBar.topItem?.title = "清单"
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let secondViewController = LandingPageDetailViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
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
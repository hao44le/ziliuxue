//
//  ServiceOverviewViewController.swift
//  
//
//  Created by Gelei Chen on 7/28/15.
//
//

import UIKit

class ServiceOverviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var teacherName = ["    Stephenie An","    Alex Song","    Julia Chen","    王小米","    黄大卫","    张佳丽","    Ken Wang","    Sara Qiao"]
    var teacherImage = ["1","2","3","4","5","6","7","8"]
    var titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
    var detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
    var like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
    
    var topName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.topName
        //self.navigationController?.navigationBar.topItem?.title = ""
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
        return self.teacherName.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ServiceOverviewTableViewCell
        cell.name.text = teacherName[indexPath.row]
        cell.titleLabel.text = titleName[indexPath.row]
        cell.detailLabel?.text = detail[indexPath.row]
        cell.like.text = like[indexPath.row]
        cell.teacherImage.image = UIImage(named: "teacher_" + self.teacherImage[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let writerDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WriterDetailViewController") as! WriterDetailViewController
        writerDetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(writerDetailVC, animated: true)
    }

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        var destinationVC = segue.destinationViewController as! WriterDetailViewController
//        destinationVC.hidesBottomBarWhenPushed = true
//        
//    }


}

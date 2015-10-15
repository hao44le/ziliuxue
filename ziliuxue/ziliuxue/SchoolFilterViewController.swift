//
//  CourseFilterViewController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/11.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolFilterViewController: UIViewController,JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource {

    var menu:JSDropDownMenu!
    
    @IBOutlet var tableView: UITableView!
    
    let location = ["地点","北京","上海","南京","杭州"]
    let time = ["时间","上午","下午","晚上"]
    let price = ["价格","<1000","1000-2000","2000-3000",">3000"]
    let peopleNum = ["人数","<10","10-50","50-100",">100"]
    let teacher = ["老师","石扬","王伟","李轶鹏","陈格雷","赵靓","王烁"]
    
    
    let category = ["专业排名","综合排名"]
    let introArray = ["US NEWS最新专业排名","US NEWS 最好大学排名"]
    let picPrefix = "courses_step1_"

    
    var locationIndex = 0
    var timeIndex = 0
    var priceIndex = 0
    var peopleNumIndex = 0
    var teacherIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.menu = JSDropDownMenu(origin: CGPointMake(0, 64), andHeight: 40)
        self.menu.indicatorColor = UIColorFromHexRGB(0xafafaf)
        self.menu.separatorColor = UIColorFromHexRGB(0xd2d2d2)
        self.menu.textColor = UIColorFromHexRGB(0x535353)
        self.menu.delegate = self
        self.menu.dataSource = self
        self.view.addSubview(self.menu)
        
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector(""))
        self.navigationItem.rightBarButtonItem = searchBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int {
        return 5
    }
    
    func haveRightTableViewInColumn(column: Int) -> Bool {
        return false
    }
    
    func widthRatioOfLeftColumn(column: Int) -> CGFloat {
        return 1
    }
    
    func currentLeftSelectedRow(column: Int) -> Int {
        switch column{
        case 0 :
            return self.locationIndex
        case 1:
            return self.priceIndex
        case 2:
            return self.peopleNumIndex
        case 3:
            return self.teacherIndex
        case 4:
            return self.timeIndex
        default:
            return 0
        }
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        switch column{
        case 0 :
            return self.location.count
        case 1:
            return self.price.count
        case 2:
            return self.peopleNum.count
        case 3:
            return self.teacher.count
        case 4:
            return self.time.count
        default:
            return 0
        }
        
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        switch column{
        case 0 :
            return self.location[self.locationIndex]
        case 1:
            return self.price[self.priceIndex]
        case 2:
            return self.peopleNum[self.peopleNumIndex]
        case 3:
            return self.teacher[self.teacherIndex]
        case 4:
            return self.time[self.timeIndex]
        default:
            return ""
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        switch indexPath.column{
        case 0 :
            return self.location[indexPath.row]
        case 1:
            return self.price[indexPath.row]
        case 2:
            return self.peopleNum[indexPath.row]
        case 3:
            return self.teacher[indexPath.row]
        case 4:
            return self.time[indexPath.row]
        default:
            return ""
        }
    }
    
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        switch indexPath.column{
        case 0 :
            self.locationIndex = indexPath.row
        case 1:
            self.priceIndex = indexPath.row
        case 2:
            self.peopleNumIndex = indexPath.row
        case 3:
            self.teacherIndex = indexPath.row
        case 4:
            self.timeIndex = indexPath.row
        default:
            return
        }
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
        cell.introLabel.text = self.introArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("toSchoolList", sender: self)
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

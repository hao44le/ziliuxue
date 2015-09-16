//
//  StudyPlanViewController.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class StudyPlanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {

    let name = ["申请总论","申请前期准备","选择申请学校","留学文书","标准化考试","网上申请","材料寄送","联系目标学校老师/秘书","录取阶段","护照预签证办理","体检和疫苗","金融服务","目的地的抵达"]
    let detailTextView = ["满分120， 最低要求90\n" + "你最高分数105\n" + "满足5/5学校要求","满分1200， 最低要求900\n" + "你最高分数950\n" + "满足2/5学校要求","3校要求1篇，2校2篇\n" + "你目前无","3校要求2封，2校3封\n" + "你目前无"]
    let first = [1]
    let second = [40,60]
    let third = [0]
    let fourth = [0]
    var selectedIndex = 0
    
    
    //var slice = [[100],[40,60],[100],[100]]
    //var percentLabel = ["5/5","2/5","0/2","0/3"]
    //var pieChartColor = [[UIColor(red: 162/250, green: 49/250, blue: 59/250, alpha: 1)],[UIColor(red: 162/250, green: 49/250, blue: 59/250, alpha: 1),UIColor.darkGrayColor()],[UIColor.darkGrayColor()],[UIColor.darkGrayColor()]]
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.interactivePopGestureRecognizer!.delegate = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
        // Do any additional setup after loading the view.
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
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
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FirstTabTableViewCell
        cell.title.text = name[indexPath.row]
        cell.detailTextView.text = detailTextView[indexPath.row]
        //cell.slice = slice[indexPath.row]
        //cell.pieChartColor = pieChartColor[indexPath.row]
        //cell.percentLabel.text = percentLabel[indexPath.row]
        //cell.pieView.reloadData()
        cell.logoImageView.image = UIImage(named: self.name[indexPath.row])
        return cell
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("newCell", forIndexPath: indexPath) 
        cell.textLabel?.text = name[indexPath.row]
        cell.imageView?.image = UIImage(named: name[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedIndex = indexPath.row
        self.performSegueWithIdentifier("toPlanOverview", sender: self)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPlanOverview" {
            let vc = segue.destinationViewController as! PlanOverviewViewController
            vc.topName = name[self.selectedIndex]
              vc.list.removeAll(keepCapacity: false)
            switch self.selectedIndex {
            case 0:
              
                 vc.list.append("为什么留学")
                 vc.list.append("经济与申请")
                 vc.list.append("目标学位")
                 vc.list.append("国内与国外发展")
                 vc.list.append("留学国家")
                 vc.list.append("资助与留学基金")
                 vc.list.append("申请流程概述")
                 vc.list.append("申请中的规范与注意事项")
                
            case 1:
                
                vc.list.append("费用估计")
                vc.list.append("成绩单")
                vc.list.append("在读证明")
                vc.list.append("其他证明材料")
                vc.list.append("社会活动")
                vc.list.append("个人奖项")
            case 2:
                
                vc.list.append("学校信息")
                vc.list.append("大学排名")
                vc.list.append("自我定位")
                vc.list.append("选择学校")
            case 3:
                vc.list.append("个人陈述")
                vc.list.append("简历")
                vc.list.append("推荐信")
                vc.list.append("研究计划")
                vc.list.append("写作样本")
                vc.list.append("制作，美化与润色")
            case 4:
                vc.list.append("TOEFL 托福")
                vc.list.append("IELTS 雅思")
                vc.list.append("SAT/ACT")
                vc.list.append("GRE")
                vc.list.append("GMAT")
                vc.list.append("要求联络考试中心寄送成绩")
            case 5:
                vc.list.append("填写表格说明")
                vc.list.append("自动生成表格样本")
            case 6:
                //370
                vc.list.append("递交考试成绩")
                vc.list.append("递交申请材料")
                vc.list.append("成绩单")
                vc.list.append("申请费用支付")
            case 7:
                vc.list.append("招生计划询问")
                vc.list.append("再次询问申请状态")
                vc.list.append("套瓷")
            case 8:
                vc.list.append("面试")
                vc.list.append("收到的notification")
                vc.list.append("选择")
                vc.list.append("入学许可")
                vc.list.append("415协议")
                
            case 9:
                vc.list.append("美国最新签证政策")
                vc.list.append("DS-160表格")
                vc.list.append("美国大使馆介绍")
                vc.list.append("成绩单准备")
                vc.list.append("存款证明")
            case 10:
                vc.list.append("国内体检地点查询")
                vc.list.append("体检注意事项")
                vc.list.append("需要打的疫苗")
                vc.list.append("小黄本")
            case 11:
                vc.list.append("申请费用支付")
                vc.list.append("办理美国银行卡")
                vc.list.append("电汇")
            case 12:
                vc.list.append("机票查询")
                vc.list.append("机票购买心得")
            default:
                break
            }
        }
    }
    

}

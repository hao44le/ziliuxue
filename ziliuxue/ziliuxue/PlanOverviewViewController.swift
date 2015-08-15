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
    var selectedName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "清单"
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = self.topName
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
        self.selectedName = list[indexPath.row]
        self.performSegueWithIdentifier("detail", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detail" {
            let vc = segue.destinationViewController as! LandingPageDetailViewController
            vc.topName = self.selectedName
            var names : [String] = []
            var titleLabelContent = self.selectedName
            var timeLabelContent = "2016.1.12 10.38"
            var introducationLabelContent = "西洋的王博士重点谈谈各国留学的优势和适合的人群。他曾留学澳洲。转学新西兰，最后到美国就业，多次参与各国留学的评论。他的经验非常值得借鉴。                                                            "
            var firstTopicLabelContent = self.selectedName + "1"
            var secondTopicLabelContent = self.selectedName + "2"
            var thirdTopicLabelContent = self.selectedName + "3"
            
            switch self.selectedName {
            case "为什么留学":
                
                /*
                视频
                keypoint
                相关信息
                input
                */

                
                
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "经济与申请":
                names.append("留学费用")
                names.append("申请费用")
                names.append("生活费用")
            case "目标学位":
                names.append("本科学位")
                names.append("硕士学位")
                names.append("博士学位")
            case "国内与国外发展":
                names.append("留学职业发展")
                names.append("国内职业发展")
                names.append("国外内自主创业")
                names.append("123")
            case "留学国家":
                names.append("留学趋势")
                names.append("为什么留学")
                names.append("留学国家比较")
            case "资助与留学基金":
                names.append("奖学金种类")
                names.append("奖学金获取难易程度")
                names.append("奖学金与总费用占比")
            case "申请流程概述":
                names.append("文书")
                names.append("表格")
                names.append("签证")
            case "申请中的规范与注意事项":
                names.append("")
                names.append("")
                names.append("")
            
        
            
            case "费用估计":
                names.append("费用估计")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "成绩单":
                names.append("高中成绩")
                names.append("本科生成绩")
                names.append("研究生成绩")
                names.append("自留学推荐")
            case "在读证明":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "其他证明材料":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "社会活动":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "个人奖项":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
         
            
            case "学校信息":
                names.append("细节信息1")
                names.append("细节信息2")
                names.append("细节信息3")
            case "大学排名":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "自我定位":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "完善个人信息"
                secondTopicLabelContent = "与以往比较"
                thirdTopicLabelContent = "与同期比较"
                
            case "选择学校":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "考虑的学校"
                secondTopicLabelContent = "获得的录取通知书"
                thirdTopicLabelContent = "被拒绝的通知书"
                
            case "个人陈述":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "上传个人陈述"
                secondTopicLabelContent = "个人陈述样本"
                thirdTopicLabelContent = "写作润色服务"
            case "简历":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "推荐信":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "研究计划":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "写作样本":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "制作，美化与润色":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
         
            case "TOEFL 托福":
                
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "IELTS 雅思":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
                titleLabelContent = "雅思考试"
                timeLabelContent = ""
                introducationLabelContent = "雅思考试分学术类和培训类两种，分别针对申请留学的学生和计划在英语语言国家参加工作或移民的人士。考试分听、说、读、写四个部分，总分9分。"
                firstTopicLabelContent = "附近的雅思课程"
                secondTopicLabelContent = "目标学校雅思分数"
                thirdTopicLabelContent = "更新雅思分数"
            case "SAT/ACT":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
                titleLabelContent = "SAT/ACT考试"
                timeLabelContent = ""
                introducationLabelContent = "SAT是由美国大学委员会（College Board）主办，其成绩是世界各国高中生申请美国大学入学资格及奖学金的重要参考，它与ACT都被称为美国高考。SAT总分共2400分，分为阅读、写作和数学三部分，由ETS承担其命题及阅卷工作。但是它们只是录取学生时参考的材料之一，不像高考一样起完全决定性的因素，其成绩有效期为2年。"
                firstTopicLabelContent = "SAT/ACT区别"
                secondTopicLabelContent = "目标学校SAT/ACT分数"
                thirdTopicLabelContent = "更新雅思分数"
            case "GRE":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "GMAT":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "要求联络考试中心寄送成绩":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
         
            case "填写表格说明":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "自动生成表格样本":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
       
            //370
            case "递交考试成绩":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "递交申请材料":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "成绩单":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "申请费用支付":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
         
            case "招生计划询问":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "再次询问申请状态":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "套瓷":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
          
            case "面试":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "收到的notification":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "选择":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "入学许可":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "415协议":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            
       
            case "美国最新签证政策":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "DS-160表格":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "美国大使馆介绍":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "成绩单准备":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "存款证明":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
         
            case "国内体检地点查询":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "体检注意事项":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "需要打的疫苗":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "小黄本":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
          
            case "申请费用支付":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "办理美国银行卡":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "电汇":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
        
            case "机票查询":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            case "机票购买心得":
                titleLabelContent = "托福考试"
                timeLabelContent = ""
                introducationLabelContent = "托福是由美国教育测验服务社（ETS）举办的英语能力考试，全名为“检定非英语为母语者的英语能力考试”，中文音译为“托福”。托福考试满分为120分，分为听说读写4项，每项占30分。"
                firstTopicLabelContent = "附近的托福课程"
                secondTopicLabelContent = "目标学校托福分数"
                thirdTopicLabelContent = "更新托福分数"
            
            default:
                break
            }
            vc.titleLabelContent = titleLabelContent
            vc.timeLabelContent = timeLabelContent
            vc.introducationLabelContent = introducationLabelContent
            vc.firstTopicLabelContent = firstTopicLabelContent
            vc.secondTopicLabelContent = secondTopicLabelContent
            vc.thirdTopicLabelContent = thirdTopicLabelContent
            vc.tableViewLeft = ["UIUC","普渡大学","斯坦福大学","MIT","华盛顿大学","卡耐基梅隆大学","加州大学伯克利分校"]
            vc.tableViewRight = ["100","90","110","110","90","110","110"]
        }
    }
    

}

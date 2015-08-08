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
            switch self.selectedName {
            case "为什么留学":
                
                /*
                视频
                keypoint
                相关信息
                input
                */

                
                
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
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
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "其他证明材料":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "社会活动":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "个人奖项":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
         
            
            case "学校信息":
                names.append("细节信息1")
                names.append("细节信息2")
                names.append("细节信息3")
            case "大学排名":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "自我定位":
                names.append("完善个人信息")
                names.append("与以往比较")
                names.append("与同期比较")
            case "选择学校":
                names.append("考虑的学校")
                names.append("获得的录取通知书")
                names.append("被拒绝的通知书")
        
            case "个人陈述":
                names.append("上传个人陈述")
                names.append("个人陈述样本")
                names.append("写作润色服务")
            case "简历":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "推荐信":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "研究计划":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "写作样本":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "制作，美化与润色":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
         
            case "TOEFL 托福":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "IELTS 雅思":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "SAT/ACT":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "GRE":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "GMAT":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "要求联络考试中心寄送成绩":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
         
            case "填写表格说明":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "自动生成表格样本":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
       
            //370
            case "递交考试成绩":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "递交申请材料":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "成绩单":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "申请费用支付":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
         
            case "招生计划询问":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "再次询问申请状态":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "套瓷":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
          
            case "面试":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "收到的notification":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "选择":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "入学许可":
                names.append("I-20")
                names.append("")
                names.append("留学经验分享")
            case "415协议":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            
       
            case "美国最新签证政策":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "DS-160表格":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "美国大使馆介绍":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "成绩单准备":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "存款证明":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
         
            case "国内体检地点查询":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "体检注意事项":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "需要打的疫苗":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "小黄本":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
          
            case "申请费用支付":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "办理美国银行卡":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "电汇":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
        
            case "机票查询":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            case "机票购买心得":
                names.append("留学目的调查")
                names.append("留学数据分析")
                names.append("留学经验分享")
            
            default:
                break
            }
            vc.names = names
        }
    }
    

}

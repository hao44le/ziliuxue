//
//  SchoolApplicationViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolApplicationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    @IBOutlet weak var applicationMethodTableView: UITableView!
    @IBOutlet weak var applicationStatisticsTableView: UITableView!
    @IBOutlet weak var applicationReuirementTableView: UITableView!
    
    let methodHeader = ["正常录取-RD","提前录取-ED","提前行动-EA","申请费用","申请方式","申请押金","联系方式"]
    let methodLeftForRD = ["申请截止日期","提前申请截止日期","放榜日期","接受录取通知书最晚日期","是否接收非秋季学期学生"]
    var methodRightForRD = ["","","","",""]
    
    
    
    let methodLeftForED = ["是否提供提前录取方案","提前录取截止日期","提前录取放榜日期"]
    var methodRightForED = ["","",""]
    
    
    let methodLeftForEA = ["是否提供提前行动方案","学生是否受限于本校的行动方案","提前行动截止日期","提前行动放榜日期"]
    var methodRightForEA = ["","","",""]
    
    let methodLeftForApplicationFee = ["申请费用","是否退还申请费","收到奖学金的学生是否取消申请费","网上申请的申请费","是否允许延期通知书","最长的考虑时间"]
    var methodRightForApplicationFee = ["","","","","",""]
    
    
    let methodLeftForApplicationWay = ["申请网址","是否接受通用申请Common Application"]
    var methodRightForApplicationWay = ["",""]
    
    let methodLeftForDeposit = ["学费押金","学费押金是否退还","宿舍押金","宿舍押金是否退还"]
    var methodRightForDeposit = ["","","",""]
    
    let methodLeftForContactInformation = ["招生办电话","招生办邮箱","招生办地址"]
    var methodRightForContactInformation = ["","",""]
    
    let requirementHeader = ["招生办要求","被考虑的学术因素","被考虑的非学术因素"]
    let requirementLeftForAR = ["招生面试","校园参观","校园之外面试","校园开放日政策","是否使用SAT/ACT作为入学标准","要求的标准化考试","带写作的ACT考试","SAT/ACT最晚必须收到日期","SAT科目考试成绩最晚必须收到日期"]
    var requirementRightForAR = ["","","","","","","","",""]
    
    
    let requirementLeftForAFC = ["高中记录的重要性","班级排名","GPA(平均分数)","标准化考试成绩","申请文书","推荐信","SAT科目考试"]
    var requirementRightForAFC = ["","","","","","",""]
    
    let requirementLeftForNFC = ["面试","课外活动","天赋能力","个人品质","家族第一代大学生","校友关系","居住地","国籍","宗教信仰","种族","志愿者活动","工作经验","申请者对本校感兴趣程度"]
    var requirementRightForNFC = ["","","","","","","","","","","","",""]
    
    
    
    let statisticsHeader = ["竞争性","录取统计","等待名单-Wait List"]
    let statisticsLeftForSelectivity = ["竞争程度","录取率","提前录取录取率","提前行动录取率","acceptance_rate_wo_early_decision"]
    var statisticsRightForSelectivity = ["","","","",""]
    let statisticsLeftForACE = ["申请者","女性申请者","男性申请者","录取的申请者","女性录取总数","男性录取总数","大一新生入学人数"]
    var statisticsRightForACE = ["","","","","","",""]
    let statisticsLeftForWL = ["是否有等待名单","被放置在等待名单的申请者","本校从等待名单中录取的申请者","从等待名单中就读的申请者"]
    var statisticsRightForWL  = ["","","",""]
    

    var collegeApplication : CollegeApplying? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false

        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == applicationMethodTableView {
            return self.methodHeader.count
        } else if tableView == applicationReuirementTableView {
            return self.requirementHeader.count
        } else {
            return self.statisticsHeader.count
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == applicationMethodTableView {
            switch section {
            case 0:
                return self.methodLeftForRD.count
            case 1:
                return self.methodLeftForED.count
            case 2:
                return self.methodLeftForEA.count
            case 3:
                return self.methodLeftForApplicationFee.count
            case 4:
                return self.methodLeftForApplicationWay.count
            case 5:
                return self.methodLeftForDeposit.count
            case 6:
                return self.methodLeftForContactInformation.count
            default:
                return 0
            }
        } else if tableView == applicationReuirementTableView {
            switch section {
            case 0:
                return self.requirementLeftForAR.count
            case 1:
                return self.requirementLeftForAFC.count
            case 2:
                return self.requirementLeftForNFC.count
            default:
                return 0
            }

        } else {
            switch section {
            case 0:
                return self.statisticsLeftForSelectivity.count
            case 1:
                return self.statisticsLeftForACE.count
            case 2:
                return self.statisticsLeftForWL.count
            default:
                return 0
            }

        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sepecificApplicationCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
        if tableView == applicationMethodTableView {
            switch indexPath.section {
            case 0:
                cell.leftLabel.text = self.methodLeftForRD[indexPath.row]
                cell.rightLabel.text = self.methodRightForRD[indexPath.row]
            case 1:
                cell.leftLabel.text = self.methodLeftForED[indexPath.row]
                cell.rightLabel.text = self.methodRightForED[indexPath.row]
            case 2:
                cell.leftLabel.text = self.methodLeftForEA[indexPath.row]
                cell.rightLabel.text = self.methodRightForEA[indexPath.row]
            case 3:
                cell.leftLabel.text = self.methodLeftForApplicationFee[indexPath.row]
                cell.rightLabel.text = self.methodRightForApplicationFee[indexPath.row]
            case 4:
                cell.leftLabel.text = self.methodLeftForApplicationWay[indexPath.row]
                cell.rightLabel.text = self.methodRightForApplicationWay[indexPath.row]
            case 5:
                cell.leftLabel.text = self.methodLeftForDeposit[indexPath.row]
                cell.rightLabel.text = self.methodRightForDeposit[indexPath.row]
            case 6:
                cell.leftLabel.text = self.methodLeftForContactInformation[indexPath.row]
                cell.rightLabel.text = self.methodRightForContactInformation[indexPath.row]
            default:
                break
            }
        } else if tableView == applicationReuirementTableView {
            switch indexPath.section {
            case 0:
                cell.leftLabel.text = self.requirementLeftForAR[indexPath.row]
                cell.rightLabel.text = self.requirementRightForAR[indexPath.row]
            case 1:
                cell.leftLabel.text = self.requirementLeftForAFC[indexPath.row]
                cell.rightLabel.text = self.requirementRightForAFC[indexPath.row]
            case 2:
                cell.leftLabel.text = self.requirementLeftForNFC[indexPath.row]
                cell.rightLabel.text = self.requirementRightForNFC[indexPath.row]
            default:
                break
            }
            
        } else {
            switch indexPath.section {
            case 0:
                cell.leftLabel.text = self.statisticsLeftForSelectivity[indexPath.row]
                cell.rightLabel.text = self.statisticsRightForSelectivity[indexPath.row]
            case 1:
                cell.leftLabel.text = self.statisticsLeftForACE[indexPath.row]
                cell.rightLabel.text = self.statisticsRightForACE[indexPath.row]
            case 2:
                cell.leftLabel.text = self.statisticsLeftForWL[indexPath.row]
                cell.rightLabel.text = self.statisticsRightForWL[indexPath.row]
            default:
                break
            }
            
        }

        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == applicationMethodTableView {
            return self.methodHeader[section]
        } else if tableView == applicationReuirementTableView {
            return self.requirementHeader[section]
        } else {
            return self.statisticsHeader[section]
        }
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

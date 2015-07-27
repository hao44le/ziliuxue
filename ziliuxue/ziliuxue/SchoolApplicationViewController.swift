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
            //regular_decision
            methodRightForRD[0] = collegeApplication!.application_deadline
            methodRightForRD[1] = collegeApplication!.priority_application_deadline
            methodRightForRD[2] = collegeApplication!.notification_date
            methodRightForRD[3] = collegeApplication!.deadline_for_accepting_admission_offers
            methodRightForRD[4] = collegeApplication!.students_accepted_for_terms_other_than_the_fall
            
            //early_decision
            methodRightForED[0] = collegeApplication!.early_decision_plan_offered
            methodRightForED[1] = collegeApplication!.early_decision_deadline
            methodRightForED[2] = collegeApplication!.early_decision_sent_by
            
            //early_action
            methodRightForEA[0] = collegeApplication!.early_action_plan_offered
            methodRightForEA[1] = collegeApplication!.students_restricted_from_applying_to_other_early_action_plans
            methodRightForEA[2] = collegeApplication!.early_action_deadline
            methodRightForEA[3] = collegeApplication!.early_action_decision_sent_by
            
            //application_fee
            methodRightForApplicationFee[0] = collegeApplication!.application_fee
            methodRightForApplicationFee[1] = collegeApplication!.application_fee_refundable
            methodRightForApplicationFee[2] = collegeApplication!.application_fee_waived_for_stdents_with_financial_need
            methodRightForApplicationFee[3] = collegeApplication!.application_fee_for_students_who_apply_online
            methodRightForApplicationFee[4] = collegeApplication!.deferred_admission_allowed
            methodRightForApplicationFee[5] = collegeApplication!.maximum_length_of_determent
            
            
            //application_formats
            methodRightForApplicationWay[0] = collegeApplication!.application_url
            methodRightForApplicationWay[1] = collegeApplication!.common_application_accepted
            
            //tuition_room_deposits
            methodRightForDeposit[0] = collegeApplication!.tuition_deposit
            methodRightForDeposit[1] = collegeApplication!.tuition_deposit_refundable
            methodRightForDeposit[2] = collegeApplication!.room_deposit
            methodRightForDeposit[3] = collegeApplication!.room_deposit_refundable
            
            //contact_information
            methodRightForContactInformation[0] = collegeApplication!.admission_phone
            methodRightForContactInformation[1] = collegeApplication!.admission_email
            methodRightForContactInformation[2] = collegeApplication!.admission_address
            
            
            //admission_requirements
            requirementRightForAR[0] = collegeApplication!.admission_interview
            requirementRightForAR[1] = collegeApplication!.campus_visit
            requirementRightForAR[2] = collegeApplication!.offcampus_interviews
            requirementRightForAR[3] = collegeApplication!.open_admission_policy
            requirementRightForAR[4] = collegeApplication!.college_use_SAT_or_ACT_in_admission_decisions
            requirementRightForAR[5] = collegeApplication!.required_standardized_tests
            requirementRightForAR[6] = collegeApplication!.ACT_with_writing_test
            requirementRightForAR[7] = collegeApplication!.SAT_ACT_scores_must_be_received_by
            requirementRightForAR[8] = collegeApplication!.SAT_subject_test_scores_must_be_received_by
            
            
            //academic_factors_considered
            requirementRightForAFC[0] = collegeApplication!.rigor_of_secondary_school_record
            requirementRightForAFC[1] = collegeApplication!.class_rank
            requirementRightForAFC[2] = collegeApplication!.GPA
            requirementRightForAFC[3] = collegeApplication!.standardized_test_scores
            requirementRightForAFC[4] = collegeApplication!.application_essay
            requirementRightForAFC[5] = collegeApplication!.recommendations
            requirementRightForAFC[6] = collegeApplication!.SAT_subject_tests
            
            //nonacademic_factors_considered
            requirementRightForNFC[0] = collegeApplication!.interview
            requirementRightForNFC[1] = collegeApplication!.extracurricular_activities
            requirementRightForNFC[2] = collegeApplication!.talent_ability
            requirementRightForNFC[3] = collegeApplication!.character_personal_qualities
            requirementRightForNFC[4] = collegeApplication!.first_generation_college_student
            requirementRightForNFC[5] = collegeApplication!.alumni_relations
            requirementRightForNFC[6] = collegeApplication!.geographical_residence
            requirementRightForNFC[7] = collegeApplication!.state_residency
            requirementRightForNFC[8] = collegeApplication!.religious_affiliation
            requirementRightForNFC[9] = collegeApplication!.race_ethnicity
            requirementRightForNFC[10] = collegeApplication!.volunteer_work
            requirementRightForNFC[11] = collegeApplication!.work_experience
            requirementRightForNFC[12] = collegeApplication!.applicants_interest_level
            
            
            //selectivity
            statisticsRightForSelectivity[0] = collegeApplication!.selectivity
            statisticsRightForSelectivity[1] = collegeApplication!.acceptance_rate
            statisticsRightForSelectivity[2] = collegeApplication!.early_decision_acceptance_rate
            statisticsRightForSelectivity[3] = collegeApplication!.early_action_acceptance_rate
            statisticsRightForSelectivity[4] = collegeApplication!.acceptance_rate_wo_early_decision
            
            
            
            //applications_acceptance_enrollments
            statisticsRightForACE[0] = collegeApplication!.applicants
            statisticsRightForACE[1] = collegeApplication!.female_applicants
            statisticsRightForACE[2] = collegeApplication!.male_applicants
            statisticsRightForACE[3] = collegeApplication!.applicants_accepted
            statisticsRightForACE[4] = collegeApplication!.female_applicants_accepted
            statisticsRightForACE[5] = collegeApplication!.male_applicants_accepted
            statisticsRightForACE[6] = collegeApplication!.freshman_enrollment
            
            
            //wait_list
            statisticsRightForWL[0] = collegeApplication!.school_has_a_wait_list
            statisticsRightForWL[1] = collegeApplication!.applicants_placed_on_wait_list
            statisticsRightForWL[2] = collegeApplication!.students_accepting_place_on_wait_list
            statisticsRightForWL[3] = collegeApplication!.students_accepted_from_wait_list
            
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier("sepecificApplicationCell", forIndexPath: indexPath) as! UITableViewCell
        if tableView == applicationMethodTableView {
            switch indexPath.section {
            case 0:
                cell.textLabel!.text = self.methodLeftForRD[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForRD[indexPath.row]
            case 1:
                cell.textLabel!.text = self.methodLeftForED[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForED[indexPath.row]
            case 2:
                cell.textLabel!.text = self.methodLeftForEA[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForEA[indexPath.row]
            case 3:
                cell.textLabel!.text = self.methodLeftForApplicationFee[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForApplicationFee[indexPath.row]
            case 4:
                cell.textLabel!.text = self.methodLeftForApplicationWay[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForApplicationWay[indexPath.row]
            case 5:
                cell.textLabel!.text = self.methodLeftForDeposit[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForDeposit[indexPath.row]
            case 6:
                cell.textLabel!.text = self.methodLeftForContactInformation[indexPath.row]
                cell.detailTextLabel!.text = self.methodRightForContactInformation[indexPath.row]
            default:
                break
            }
        } else if tableView == applicationReuirementTableView {
            switch indexPath.section {
            case 0:
                cell.textLabel!.text = self.requirementLeftForAR[indexPath.row]
                cell.detailTextLabel!.text = self.requirementRightForAR[indexPath.row]
            case 1:
                cell.textLabel!.text = self.requirementLeftForAFC[indexPath.row]
                cell.detailTextLabel!.text = self.requirementRightForAFC[indexPath.row]
            case 2:
                cell.textLabel!.text = self.requirementLeftForNFC[indexPath.row]
                cell.detailTextLabel!.text = self.requirementRightForNFC[indexPath.row]
            default:
                break
            }
            
        } else {
            switch indexPath.section {
            case 0:
                cell.textLabel!.text = self.statisticsLeftForSelectivity[indexPath.row]
                cell.detailTextLabel!.text = self.statisticsRightForSelectivity[indexPath.row]
            case 1:
                cell.textLabel!.text = self.statisticsLeftForACE[indexPath.row]
                cell.detailTextLabel!.text = self.statisticsRightForACE[indexPath.row]
            case 2:
                cell.textLabel!.text = self.statisticsLeftForWL[indexPath.row]
                cell.detailTextLabel!.text = self.statisticsRightForWL[indexPath.row]
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

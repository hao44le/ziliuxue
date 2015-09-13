//
//  SchoolRankingViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolRankingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var nationalUniversityLabel: UILabel!

    var rankingLeft = ["分数","高中平均GPA","平均新生保持率","<20学生的课","<50学生的课","学生老师比例","2013秋季接受率","6年毕业率","毕业率预期","Overperformance/Underperformance","毕业滞留排名","互评得分","教师资源排名","全职教师占比","学生选择排名","SAT/ACT 25% - 75%区间","高中班级的TOP10％的新生","高中班级的TOP25％的新生","财政资源排名","校友捐赠排名","平均校友捐赠比例"]
    var rankingRight = ["100","4.9(5)","98%","70.9%","11%","6:1","7.4%","97%","94%","","","","","","","","","","","",""]
    
    var collegeRanking : CollegeRanking? {
        didSet {
            //print("1")
            
            self.rankingRight[0] = collegeRanking!.score
            self.rankingRight[1] = collegeRanking!.high_school_counselor_score
            self.rankingRight[2] = collegeRanking!.average_freshman_retention_rate
            self.rankingRight[3] = collegeRanking!.classes_with_fewer_than_20_students
            self.rankingRight[4] = collegeRanking!.classes_with_50_or_more_students
            self.rankingRight[5] = collegeRanking!.student_falculty_ratio
            self.rankingRight[6] = collegeRanking!.acceptance_rate
            self.rankingRight[7] = collegeRanking!.six_year_graduation_rate
            self.rankingRight[8] = collegeRanking!.predicated_graduation_rate
            self.rankingRight[9] = collegeRanking!.overperformance_over_underperformance
            self.rankingRight[10] = collegeRanking!.graduation_and_retention_rank
            self.rankingRight[11] = collegeRanking!.peer_assessment_score
            self.rankingRight[12] = collegeRanking!.faculty_resources_rank
            self.rankingRight[13] = collegeRanking!.percent_of_faculty_who_are_fulltime
            self.rankingRight[14] = collegeRanking!.student_selectivity_rank
            self.rankingRight[15] = collegeRanking!.SAT_ACT_25th_75th_percentile
            self.rankingRight[16] = collegeRanking!.freshmen_in_top10percent_of_high_school_class
            self.rankingRight[17] = collegeRanking!.freshmen_in_top25percent_of_high_school_class
            self.rankingRight[18] = collegeRanking!.financial_resource_rank
            self.rankingRight[19] = collegeRanking!.alumni_giving_rank
            self.rankingRight[20] = collegeRanking!.average_alumni_giving_rate
        }
    }
    
    
    
    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
 
    @IBAction func swipeLeft(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
  
        // Do any additional setup after loading the view.
        self.navigationItem.title = "排名"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingLeft.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sepecifcRankingCell", forIndexPath: indexPath) as! UITableViewCell
        if(indexPath.row % 2 == 0){
            cell.contentView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.textLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.detailTextLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        }

        cell.textLabel!.text = rankingLeft[indexPath.row]
        cell.detailTextLabel!.text = rankingRight[indexPath.row]
        /*
        if DeviceType.IS_IPHONE_6{
            cell.firstLabelWidth.constant = 187
        } else if DeviceType.IS_IPHONE_6P{
            cell.firstLabelWidth.constant = 205
        }*/
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 60))
        let label = UILabel(frame: CGRectMake(0, 0, 60, 60))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints()
        headerView.addSubview(label)
        label.text = "排名：#1"

        return label
        
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

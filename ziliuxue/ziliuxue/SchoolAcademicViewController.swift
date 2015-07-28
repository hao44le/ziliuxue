//
//  SchoolAcademicViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolAcademicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XYPieChartDataSource,XYPieChartDelegate {

    @IBOutlet weak var academicTableView: UITableView!
    @IBOutlet weak var facultyTableView: UITableView!
    
    @IBOutlet weak var graducationTableView: UITableView!
    @IBOutlet weak var pieView: XYPieChart!
    let facultyLeft = ["师生比","教师总数","少数派","国际学生","全职博士以上教师","研究生上课占比"]
    var facultyRight = ["","","","","",""]
    
    let academicLeft = ["提供的课程","优秀的本科学生可否参加研究生课程","专业预备教育","提供的教师资格证","提供教育认证的领域","与其他学校的交换项目"]
    var academicRight = ["","","","","",""]
    
    
    let graduationLeft = ["平均大一新生保留率","六年毕业比率","每年授予的学术学位","每年授予的硕士学位","每年博士研究","毕业之后继续深造","在法律继续深造","在医学继续深造"]
    var graduationRight = ["","","","","","","",""]
    
    var pieChartColor = [UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1),UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)]
    var slices = [11,8,6,6,6]
    var text = ["经济学","政治学","生物","心理学","公共政策"]
    
    @IBAction func swipeRight(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    var collegeAcademic : CollegeAcademic?{
        didSet{
            var counter = 0
            collegeAcademic!.five_most_popular_majors.enumerateKeysAndObjectsUsingBlock { (key:AnyObject!, value:AnyObject!, bool:UnsafeMutablePointer<ObjCBool>) -> Void in
                //self.text[counter] = key as! String
                self.slices[counter] = dropLast(value as! String).toInt()!
                
                counter++
            }
            
            
            facultyRight[0] = collegeAcademic!.student_faculty_ratio
            facultyRight[1] = collegeAcademic!.total_faculty
            facultyRight[2] = collegeAcademic!.minority
            facultyRight[3] = collegeAcademic!.international
            facultyRight[4] = collegeAcademic!.full_time_faculty_with_phd_or_terminal_degree
            facultyRight[5] = collegeAcademic!.classes_taught_by_graduate_assistants
            
            
            academicRight[0] = collegeAcademic!.degrees_offered
            academicRight[1] = collegeAcademic!.qualified_undergraduate_may_take_graduate_classes
            academicRight[2] = collegeAcademic!.preprofessional_programs
            academicRight[3] = collegeAcademic!.teacher_certification_offered_in
            academicRight[4] = collegeAcademic!.subject_areas_offering_education_certification
            academicRight[5] = collegeAcademic!.student_exchange_programs_offered_with
            
            
            graduationRight[0] = collegeAcademic!.average_freshman_retention_rate
            graduationRight[1] = collegeAcademic!.six_year_graduation_rate
            graduationRight[2] = collegeAcademic!.bachelors_degrees_awarded
            graduationRight[3] = collegeAcademic!.masters_degrees_awarded
            graduationRight[4] = collegeAcademic!.doctoral_degrees_research
            graduationRight[5] = collegeAcademic!.pursued_further_study_immediately_after_graduation
            graduationRight[6] = collegeAcademic!.pursued_further_study_in_law
            graduationRight[7] = collegeAcademic!.pursued_further_study_in_medicine
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.pieView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
        
        self.pieView.dataSource = self
        self.pieView.delegate = self
        self.pieView.startPieAngle = CGFloat(M_PI_2)
        self.pieView.animationSpeed = 1.5
        self.pieView.showLabel = true
        self.pieView.labelColor = UIColor.whiteColor()
        self.pieView.labelFont = UIFont.systemFontOfSize(15)
        self.pieView.labelRadius = 100
        self.pieView.showPercentage = false
        self.pieView.pieCenter = CGPointMake(ScreenSize.SCREEN_WIDTH / 2, 150)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PieChart DataSource
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
        return UInt(self.slices.count)
    }
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
        return self.pieChartColor[Int(index)]
    }
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
        return CGFloat(self.slices[Int(index)])
    }
    func pieChart(pieChart: XYPieChart!, textForSliceAtIndex index: UInt) -> String! {
        return self.text[Int(index)]
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == facultyTableView {
            return self.facultyLeft.count
            

        } else if tableView == academicTableView {
            return self.academicLeft.count
        } else {
            return self.graduationLeft.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        if tableView == facultyTableView {
            cell.textLabel?.text = self.facultyLeft[indexPath.row]
            cell.detailTextLabel?.text = self.facultyRight[indexPath.row]
        } else if tableView == academicTableView {
            cell.textLabel?.text = self.academicLeft[indexPath.row]
            cell.detailTextLabel?.text = self.academicRight[indexPath.row]
        } else {
            
            cell.textLabel?.text = self.graduationLeft[indexPath.row]
            cell.detailTextLabel?.text = self.graduationRight[indexPath.row]
        }
        
        return cell
        
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

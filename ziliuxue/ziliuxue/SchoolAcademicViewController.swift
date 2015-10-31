//
//  SchoolAcademicViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class SchoolAcademicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let header = ["教师/教室","课程体系","毕业/保有率"]
    let facultyLeft = ["师生比","教师总数","少数派","国际学生","全职博士以上教师","研究生上课占比"]
    var facultyRight = ["","","","","",""]
    
    let academicLeft = ["提供的课程","优秀的本科学生可否参加研究生课程","专业预备教育","提供的教师资格证","提供教育认证的领域","与其他学校的交换项目"]
    var academicRight = ["","","","","",""]
    
    
    let graduationLeft = ["平均大一新生保留率","六年毕业比率","每年授予的学术学位","每年授予的硕士学位","每年博士研究","毕业之后继续深造","在法律继续深造","在医学继续深造"]
    var graduationRight = ["","","","","","","",""]
    
    var pieChartColor = [UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1),UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)]
    var slices = [11,8,6,6,6]
    var text = ["经济学","政治学","生物","心理学","公共政策"]

    @IBOutlet weak var scrollView: UIScrollView!
    var source = ""
    var collegeAcademic : CollegeAcademic?{
        didSet{
            var counter = 0
            collegeAcademic!.five_most_popular_majors.enumerateKeysAndObjectsUsingBlock { (key:AnyObject!, value:AnyObject!, bool:UnsafeMutablePointer<ObjCBool>) -> Void in
                //self.text[counter] = key as! String
                self.slices[counter] = Int(String((value as! String).characters.dropLast()))!
                
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
        
        //self.pieView.reloadData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if source == "mySchool"{
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "学术信息"
        
        if source == "mySchool" {
            let dismissButton = UIButton(type:UIButtonType.Custom)
            dismissButton.frame = CGRectMake(10, 30, 25, 25)
            
            dismissButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
            dismissButton.setImage(UIImage(named:"return"), forState: UIControlState.Normal)
            scrollView.addSubview(dismissButton)
            let titleLabel = UILabel(frame: CGRectMake(15, 30, self.view.frame.width - 30, 25))
            titleLabel.text = "学术信息"
            titleLabel.textAlignment = NSTextAlignment.Center
            scrollView.addSubview(titleLabel)

            
            
        }
//        self.pieView.dataSource = self
//        self.pieView.delegate = self
//        self.pieView.startPieAngle = CGFloat(M_PI_2)
//        self.pieView.animationSpeed = 1.5
//        self.pieView.showLabel = true
//        self.pieView.labelColor = UIColor.whiteColor()
//        self.pieView.labelFont = UIFont.systemFontOfSize(15)
//        self.pieView.labelRadius = 100
//        self.pieView.showPercentage = false
//        self.pieView.pieCenter = CGPointMake(ScreenSize.SCREEN_WIDTH / 2, 150)
//        // Do any additional setup after loading the view.
    }
    func back(){
        
        self.navigationController!.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    // MARK: PieChart DataSource
//    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
//        return UInt(self.slices.count)
//    }
//    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
//        return self.pieChartColor[Int(index)]
//    }
//    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
//        return CGFloat(self.slices[Int(index)])
//    }
//    func pieChart(pieChart: XYPieChart!, textForSliceAtIndex index: UInt) -> String! {
//        return self.text[Int(index)]
//    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.facultyLeft.count
            

        } else if section == 1 {
            return self.academicLeft.count
        } else {
            return self.graduationLeft.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if(indexPath.row % 2 == 0){
            cell.contentView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.textLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.detailTextLabel?.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = self.facultyLeft[indexPath.row]
            cell.detailTextLabel?.text = self.facultyRight[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = self.academicLeft[indexPath.row]
            cell.detailTextLabel?.text = self.academicRight[indexPath.row]
        } else {
            
            cell.textLabel?.text = self.graduationLeft[indexPath.row]
            cell.detailTextLabel?.text = self.graduationRight[indexPath.row]
        }
        
        return cell
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 60))
        let label = UILabel(frame: CGRectMake(0, 0, 60, 60))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = true
        headerView.addSubview(label)
        //label.text = "1"
        
        label.text = header[section]
        return label
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
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

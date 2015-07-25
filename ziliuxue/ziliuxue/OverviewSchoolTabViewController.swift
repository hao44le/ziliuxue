//
//  OverviewSchoolTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class OverviewSchoolTabViewController: UIViewController,SwipeViewDataSource,UITableViewDelegate,UITableViewDataSource {

    
    
    
    @IBOutlet weak var acceptance_rate: UILabel!
    
    @IBOutlet weak var applicationDeadline: UILabel!
    
    @IBOutlet weak var numberOfStudent: UILabel!
    
    @IBOutlet weak var tuitionLabel: UILabel!
    
    @IBOutlet weak var costSecondDescription: UILabel!
    @IBOutlet weak var costFirstDescription: UILabel!
    @IBOutlet weak var applicationDescriptionLabel: UILabel!
    @IBOutlet weak var universityDescription: UITextView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var swipeView: SwipeView!
    
    @IBOutlet weak var basicInfoTableView: UITableView!
    
    @IBOutlet weak var applicationInfoTableView: UITableView!
    
    @IBOutlet weak var academicInfoTableView: UITableView!
    
    @IBOutlet weak var costInfoTableView: UITableView!
    
    var basicInfoLeft = ["学校类型","成立时间","宗教联系","学期","地理","2013年捐款"]
    var basicInfoRight = ["私立，男女同校","1746","无","学期","郊区","＄18,786,132,000"]
    
    var applicationInfoFirstCell = "当申请普林斯顿大学，一定要注意申请截止时间1月1日，无论ACT或SAT分数如何，一定要在1月1日前递交申请材料。普林斯顿大学的申请费用为65美元。它是具有选择性的大学，有7.4%的录取率"
    var applicationInfoLeft = ["选修课","2013秋季接受率","申请截止日期","SAT/ACT日期"]
    var applicationInfoRight = ["多数选修","7.4%","1月1日","1月1日"]
    
    var academicInfoLeft = ["课程大小","师生比例","4年毕业比例","最流行学科","经济","政治学和政府","分子生物","心理学","公共决策分析"]
    var academicInfoRight = ["多数<20","6:1","88%","","11%","8%","6%","6%","6%"]
    
    var costFirstCell = "在普林斯顿大学，全日制本科生58.8%的接受某种形式的基于需要的财政援助，平均需要为基础的教学或补助金是38756美元。"
    var costSecondCell = "支付大学费用并不一定是困难的或毁灭性的。转至支付大学的知识中心，以获取有关筹集资金，减低成本的建议，或使用美国新闻529 Finder来选择最佳的税务优惠的大学投资账户适合您"
    var costInfoLeft = ["学费和费用","生活费用","书本和其他用品费用","预估个人花费","平均奖学金发放","学生收到的财政资助比例"]
    var costInfoRight = ["＄41,820(2014-15)","＄13,620(2014-15)","$1,050","$2,475","$38,756","61%"]
    
    var imageArray = ["classroom","classroom2","universityBack"]
    var collegeName = "Pricenton University"
    
    var college: College?
    var collegeOverview : CollegeOverview?
    var collegeRanking : CollegeRanking?
    var collegeApplying : CollegeApplying?
    var collegeAcademic : CollegeAcademic?
    var collegeFinancial : CollegeFinancial?
    
    var firstImageOfSwipeView : UIImageView = UIImageView()
    var secondImageOfSwipeView : UIImageView = UIImageView()
    var thirdImageOfSwipeView : UIImageView = UIImageView()

    
    var collegeDetail : CollegeDetail? {
        didSet{
            self.college = collegeDetail!.college
            
            
            self.collegeName = self.college!.name
            
            self.collegeOverview = collegeDetail!.collegeOverview
            self.collegeRanking = collegeDetail!.collegeRanking
            self.collegeApplying = collegeDetail!.collegeApplying
            self.collegeAcademic = collegeDetail!.collegeAcademic
            self.collegeFinancial = collegeDetail!.collegeFinancial
            
            
            
            /*
            firstImageOfSwipeView.sd_setImageWithURL(NSURL(string: ServerConstant.baseURL + college!.photos[0]), placeholderImage: UIImage(named: imageArray[0]), options: SDWebImageOptions.AllowInvalidSSLCertificates)
            secondImageOfSwipeView.sd_setImageWithURL(NSURL(string: ServerConstant.baseURL + college!.photos[1]), placeholderImage: UIImage(named: imageArray[1]), options: SDWebImageOptions.AllowInvalidSSLCertificates)
            thirdImageOfSwipeView.sd_setImageWithURL(NSURL(string: ServerConstant.baseURL + college!.photos[2]), placeholderImage: UIImage(named: imageArray[2]), options: SDWebImageOptions.AllowInvalidSSLCertificates)
            */
            firstImageOfSwipeView.image = UIImage(named: college!.name + " photo1")
            secondImageOfSwipeView.image = UIImage(named: college!.name + " photo2")
            thirdImageOfSwipeView.image = UIImage(named: college!.name + " photo3")
        }
    }
    
    @IBAction func rankingMoreButtonPressed(sender: UIButton) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    @IBAction func applicationMoreButtonPressed(sender: UIButton) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 2
    }
    
    @IBAction func academicMoreButtonPressed(sender: UIButton) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 3
    }
    
    @IBAction func costMoreButtonPressed(sender: UIButton) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 4
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeView.pagingEnabled = true
        self.applicationDescriptionLabel.text = applicationInfoFirstCell
        self.costFirstDescription.text = costFirstCell
        self.costSecondDescription.text = costSecondCell
        self.setUpView()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        //self.logoImageView.sd_setImageWithURL(NSURL(string: ServerConstant.baseURL + college!.logo), placeholderImage: UIImage(named: "defaultImage"), options: SDWebImageOptions.AllowInvalidSSLCertificates)
        self.logoImageView.image = UIImage(named: college!.name + " logo")
        self.universityName.text = self.collegeName
        self.tuitionLabel.text = self.collegeOverview!.tuition_and_fees
        //self.numberOfStudent.text = self.collegeOverview!.
        self.applicationDeadline.text = self.collegeOverview!.application_deadline
        self.acceptance_rate.text = self.collegeOverview!.acceptance_rate
        self.basicInfoRight[0] = self.collegeOverview!.school_type
        self.basicInfoRight[1] = self.collegeOverview!.year_founded
        self.basicInfoRight[2] = self.collegeOverview!.religious_affiliation
        self.basicInfoRight[3] = self.collegeOverview!.academic_calendar
        self.basicInfoRight[4] = self.collegeOverview!.setting
        self.basicInfoRight[5] = self.collegeOverview!.endowment
        
        self.applicationInfoRight[0] = self.collegeOverview!.selectivity
        self.applicationInfoRight[1] = self.collegeOverview!.acceptance_rate
        self.applicationInfoRight[2] = self.collegeOverview!.application_deadline
        self.applicationInfoRight[3] = self.collegeOverview!.SAT_ACT_scores_must_be_received_by
        
        self.academicInfoRight[1] = self.collegeOverview!.student_faculty_ration
        self.academicInfoRight[2] = self.collegeOverview!.four_year_graduation_rate
        
        var counter = 4
        self.collegeOverview?.five_most_popular_majors.enumerateKeysAndObjectsUsingBlock({ (key:AnyObject!, value:AnyObject!, bool:UnsafeMutablePointer<ObjCBool>) -> Void in
            //println(key)
            self.academicInfoLeft[counter] = key as! String
            self.academicInfoRight[counter] = value as! String
            counter++
        })
        
        
        self.costInfoRight[0] = self.collegeFinancial!.tuition_and_fees
        self.costInfoRight[1] = self.collegeFinancial!.room_and_board
        self.costInfoRight[2] = self.collegeFinancial!.estimated_cost_of_books_and_supplies
        self.costInfoRight[3] = self.collegeFinancial!.estimated_personal_expenses
        self.costInfoRight[4] = self.collegeFinancial!.average_need_based_scholarship
        self.costInfoRight[5] = self.collegeFinancial!.students_who_received_need_based_scholarship
        
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.collegeName
        //println(college!.name + college!.logo)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        //self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
   
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
       
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer!.enabled = true
        
    }
    
     // MARK: SwipeView
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 3
    }
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        let created = UIView(frame: swipeView.bounds)
        let imageView = UIImageView(frame: created.bounds)
        if (college != nil) {
            if let image = UIImage(named: college!.name + "photo\(index)") {
                imageView.image = image
            } else {
                //println(ServerConstant.baseURL + college!.photos[index])
                switch index {
                case 0:
                    imageView.image = firstImageOfSwipeView.image
                case 1:
                    imageView.image = secondImageOfSwipeView.image
                case 2:
                    imageView.image = thirdImageOfSwipeView.image
                default:
                    break
                }
             
                
                
            }
        } else {
            imageView.image = UIImage(named: imageArray[index])
        }
        
        created.addSubview(imageView)
        
        return created
    }
    
    func swipeViewItemSize(swipeView: SwipeView!) -> CGSize {
        return self.swipeView.bounds.size
    }
    
    func swipeViewCurrentItemIndexDidChange(swipeView: SwipeView!) {
        self.pageControl.currentPage = swipeView.currentPage
    }

    // MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == basicInfoTableView{
            return basicInfoLeft.count
        } else if tableView == applicationInfoTableView{
            return applicationInfoLeft.count
        } else if tableView == academicInfoTableView {
            return academicInfoLeft.count
        } else if tableView == costInfoTableView{
            return costInfoLeft.count
        }
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView == basicInfoTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("basicInfoCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
            cell.leftLabel.text = basicInfoLeft[indexPath.row]
            cell.rightLabel.text = basicInfoRight[indexPath.row]
            return cell
        } else if tableView == applicationInfoTableView{
                let cell = tableView.dequeueReusableCellWithIdentifier("applicationInfoCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
                cell.leftLabel.text = applicationInfoLeft[indexPath.row]
                cell.rightLabel.text = applicationInfoRight[indexPath.row]
                return cell
            
        } else if tableView == academicInfoTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("academicInfoCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
            cell.leftLabel.text = academicInfoLeft[indexPath.row]
            cell.rightLabel.text = academicInfoRight[indexPath.row]
            
            
            return cell
        } else if tableView == costInfoTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("costInfoCell", forIndexPath: indexPath) as! CollegeInfoTableViewCell
            cell.leftLabel.text = costInfoLeft[indexPath.row]
            cell.rightLabel.text = costInfoRight[indexPath.row]
            return cell
        }
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
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

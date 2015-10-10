//
//  OverviewSchoolTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class OverviewSchoolTabViewController: UIViewController,SwipeViewDataSource,XYPieChartDataSource,XYPieChartDelegate{

    
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    
    @IBOutlet weak var pieView: XYPieChart!
    
    
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
    
    var pieChartColor = [UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1),UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)]
    var slices = [11,8,6,6,6]
    var text = ["经济学","政治学","生物","心理学","公共政策"]
    
    var college: College? {
        didSet{
            firstImageOfSwipeView.image = UIImage(named: college!.name + " photo1")
            secondImageOfSwipeView.image = UIImage(named: college!.name + " photo2")
            thirdImageOfSwipeView.image = UIImage(named: college!.name + " photo3")
            self.collegeName = self.college!.name
        }
    }
    var collegeDetail : CollegeDetail?{
        didSet{
            self.collegeOverview = collegeDetail!.collegeOverview
            self.collegeFinancial = collegeDetail!.collegeFinancial
            self.college = collegeDetail!.college
        }
    }
    var collegeOverview : CollegeOverview?
    //var collegeRanking : CollegeRanking?
    //var collegeApplying : CollegeApplying?
    //var collegeAcademic : CollegeAcademic?
    var collegeFinancial : CollegeFinancial?
    
    var firstImageOfSwipeView : UIImageView = UIImageView()
    var secondImageOfSwipeView : UIImageView = UIImageView()
    var thirdImageOfSwipeView : UIImageView = UIImageView()

        
    @IBAction func rankingMoreButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toRanking", sender: self)
    }
    
    @IBAction func applicationMoreButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toApplication", sender: self)
    }
    
    @IBAction func academicMoreButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toAcamidec", sender: self)
    }
    
    @IBAction func costMoreButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("toCost", sender: self)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "大学", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        swipeView.autoscroll = 0
        swipeView.pagingEnabled = true
        self.setUpView()
        
    }
    
    func setUpView(){
        
        let shareButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        shareButton.backgroundColor = UIColor.clearColor()
        shareButton.setImage(UIImage(named: "share_button_normal"), forState: UIControlState.Normal)
        shareButton.setImage(UIImage(named: "share_button_highlighted"), forState: UIControlState.Highlighted)
        //shareButton.addTarget(self, action: Selector(""), forControlEvents: UIControlEvents.TouchUpInside)
        let shareItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem = shareItem
 
        
        //self.logoImageView.sd_setImageWithURL(NSURL(string: ServerConstant.baseURL + college!.logo), placeholderImage: UIImage(named: "defaultImage"), options: SDWebImageOptions.AllowInvalidSSLCertificates)
        
        self.backgroundScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1735)
        
        self.logoImageView.image = UIImage(named: college!.name + " logo")
        self.logoImageView.layer.cornerRadius = 54
        self.logoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.logoImageView.layer.borderWidth = 2
        //cell.universityName.sizeToFit()
        self.logoImageView.clipsToBounds = true
        
        self.pieView.dataSource = self
        self.pieView.delegate = self
        self.pieView.startPieAngle = CGFloat(M_PI_2)
        self.pieView.animationSpeed = 1.5
        self.pieView.showLabel = true
        self.pieView.labelColor = UIColor.whiteColor()
        self.pieView.labelFont = UIFont.systemFontOfSize(10)
        self.pieView.labelRadius = 40
        self.pieView.pieRadius = 60
        self.pieView.showPercentage = false
        self.pieView.pieCenter = CGPointMake(ScreenSize.SCREEN_WIDTH / 2, 50)


    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.hidesBottomBarWhenPushed = true
        //self.tabBarController?.tabBar.hidden = true
        //self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.topItem?.title = self.collegeName
        //println(college!.name + college!.logo)
        self.pieView.reloadData()
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
            case "toRanking":
                let vc = segue.destinationViewController as! SchoolRankingViewController
                vc.collegeRanking = collegeDetail!.collegeRanking
            case "toApplication":
                let vc = segue.destinationViewController as! SchoolApplicationViewController
                vc.collegeApplication = collegeDetail!.collegeApplying
            
            
            case "toAcamidec":
                let vc = segue.destinationViewController as! SchoolAcademicViewController
                vc.collegeAcademic = collegeDetail!.collegeAcademic
            case "toCost":
                let vc = segue.destinationViewController as! SchoolCostViewController
                vc.collegeCost = collegeDetail!.collegeFinancial
        default:
            break
        }
    }
    

}

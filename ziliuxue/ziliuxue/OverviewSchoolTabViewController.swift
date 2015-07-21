//
//  OverviewSchoolTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class OverviewSchoolTabViewController: UIViewController,SwipeViewDataSource,UITableViewDelegate,UITableViewDataSource {

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
    var costInfoLeft = ["学费和费用","生活费用","财政资助统计","基于需要的自助申请","需求全满足","收到的财政资助申请","收到的自我资助申请","需求满足的平均数"]
    var costInfoRight = ["＄41,820(2014-15)","＄13,620(2014-15)","","63.9%","100%","58.8%","58.5%","100%"]
    
    var image = ["classroom","classroom2","universityBack"]
    var collegeName = "Pricenton University"
    
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
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.collegeName
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
        imageView.image = UIImage(named: image[index])
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

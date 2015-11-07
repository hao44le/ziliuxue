//
//  SecondTabViewController.swift
//
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class SecondTabViewController: UIViewController,MCCardPickerCollectionViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var universityArray : [College] = []
    var collegeDetail : CollegeDetail?
    var selectedUniversity : College?
    let kCellIdentifier = "MCSampleCell"
    let cardViewController = MCCardPickerCollectionViewController()
    
    
    var backgroundImageName = "University of Chicago photo2"
    var avatarImageName = "University of Chicago logo"
    var universityChineseName = "普林斯顿大学"
    var universityEnglishName = "Princeton University"
    var universityLocation = "Monstroopolis, SW"
    var universityDescription = "普林斯顿大学是美国一所享誉世界的顶尖私立研究型大学，位于美国新泽西州的普林斯顿，八所常春藤盟校之一。学校于1746年在新泽西州伊丽莎白镇创立，是美国殖民时期第四所成立的高等教育学院，当时名为“新泽西学院”，并在1896年正式改名为普林斯顿大学。"
    var oneYearTuitionTop = "41820"
    var numberOfStudentTop = "5,323"
    var overallRankingTop = "#1"
    var applicationDeadlineTop = "1月1日"
    var acceptenceRate = "7.4%"
    
    var application_info_board_first_right = "1月3日"
    var application_info_board_second_right = "2月8日"
    var application_info_board_third_right = "$65"
    var application_info_board_fourth_right = "否"
    
    
    var ranking_info_board_first_right = "4.9"
    var ranking_info_board_second_right = "98%"
    var ranking_info_board_third_right = "70.9%"
    var ranking_info_board_fourth_right = "11%"
    
    var academic_info_board_first_right = "多数<20"
    var academic_info_board_second_right = "6:1"
    var academic_info_board_third_right = "88%"
    
    var cost_info_board_first_right = "$41,820"
    var cost_info_board_second_right = "$13,620"
    var cost_info_board_third_right = "$65"
    var cost_info_board_fourth_right = "否"
    
    
    
    var mult : UInt32 = 100
    let count = 4
    let parties  = [
        "计算机科学", "插画专业", "应用物理", "统计学专业", "平面设计"
    ]
    
    
    let source = "*所有信息更新于2015年8月28号，来源：US News，教育时空网，大学官网"
    let oneYearTuitionBottom = "一年学费"
    let numberOfStudentBottom = "学生数量"
    let overallRankingBottom = "综合排名"
    let applicationDeadlineBottom = "截止申请"
    let acceptenceRateBottom = "接受率"
    
    let application_info_board_first_left = "申请截止日期"
    let application_info_board_second_left = "SAT/ACT日期"
    let application_info_board_third_left = "申请费用"
    let application_info_board_fourth_left = "是否退还申请费用"
    
    
    
    let ranking_info_board_first_left = "高中生平均GPA"
    let ranking_info_board_second_left = "平均新生保持率"
    let ranking_info_board_third_left = "<20学生的课"
    let ranking_info_board_fourth_left = "<50学生的课"
    
    let academic_info_board_first_left = "课程大小"
    let academic_info_board_second_left = "师生比例"
    let academic_info_board_third_left = "4年毕业比率"
    let academic_info_board_fourth_left = "五大热门专业"
    
    let cost_info_board_first_left = "平均奖学金发放"
    let cost_info_board_second_left = "一学年费用"
    let cost_info_board_third_left = "一学年生活费用"
    let cost_info_board_fourth_left = "被资助学生比例"

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        let path = NSBundle.mainBundle().pathForResource("College", ofType: "plist")
        
        
        
        let data : NSArray = NSArray(contentsOfFile: path!)!
        for school in data {
            let id = school.objectForKey("_id") as! String
            let name = school.objectForKey("name") as! String
            let general = school.objectForKey("general") as! NSDictionary
            
            //ServerMethods.getCollegeDetail(id)
            let website = general.objectForKey("website") as! String
            let logo = name + " logo"
            
            let address = general.objectForKey("address") as! NSDictionary
            let photos = [name + " photo1",name + " photo2",name + " photo3"]
            
            let city = address.objectForKey("city") as! String
            let country = address.objectForKey("country") as! String
            let state = address.objectForKey("state") as! String
            let zipcode = address.objectForKey("zipcode") as! String
            
            let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
            universityArray.append(college)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "success:", name: "getCollegeDetailSuccessed", object: nil)
        // Do any additional setup after loading the view.
        self.navigationItem.title = "我的学校"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "学校", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        cardViewController.delegate = self
        cardViewController.collectionView.registerClass(SchoolCardCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        cardViewController.collectionView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        
        cardViewController.presentInViewController(self)
        
        
        self.setupLeftMenuButton()
    }
    func success(notification:NSNotification){
        let userInfo : NSDictionary = notification.userInfo!
        print(userInfo.objectForKey("collegeDetail"), terminator: "")
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.universityArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SchoolCardCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! SchoolCardCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        return cell
    }
    func cardPickerCollectionViewController(cardPickerCollectionViewController: MCCardPickerCollectionViewController!, preparePresentingView presentingView: UIView!, fromSelectedCell cell: UICollectionViewCell!) {
        
        for subView in presentingView.subviews {
            subView.removeFromSuperview()
        }
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = cardPickerCollectionViewController
        
       
        
        let width = self.view.frame.width
        
        

        
        
        
        
        let backgroundImageView = UIImageView(frame: CGRectMake(0, 0, width, 222.5))
        backgroundImageView.image = UIImage(named: backgroundImageName)
        backgroundImageView.contentMode = UIViewContentMode.ScaleToFill
        
        let avatarImageView = UIImageView(frame: CGRectMake(width / 2 - 38.5,43,77,77))
        avatarImageView.image = UIImage(named: avatarImageName)
        
        let universityChineseNameLabel = UILabel(frame: CGRectMake(width / 2 - 54.5,128,109,25))
        universityChineseNameLabel.text = universityChineseName
        universityChineseNameLabel.textAlignment = NSTextAlignment.Center
        universityChineseNameLabel.textColor = UIColor.whiteColor()
        universityChineseNameLabel.font = UIFont.systemFontOfSize(14.5)
        
        
        let universityEnglishNameLabel = UILabel(frame: CGRectMake(width / 2 - 54.5,158,109,17))
        universityEnglishNameLabel.text = universityEnglishName
        universityEnglishNameLabel.textAlignment = NSTextAlignment.Center
        universityEnglishNameLabel.textColor = UIColor.whiteColor()
        universityEnglishNameLabel.font = UIFont.systemFontOfSize(9.5)
        
        let universityLocationLabel = UILabel(frame: CGRectMake(width / 2 - 30.5,183,61,15))
        universityLocationLabel.text = universityLocation
        universityLocationLabel.textAlignment = NSTextAlignment.Center
        universityLocationLabel.textColor = UIColor.whiteColor()
        universityLocationLabel.font = UIFont.systemFontOfSize(6.0)
        
        
        let universityDescriptionLabel = UILabel(frame: CGRectMake(10,225,width - 20,64))
        universityDescriptionLabel.text = universityDescription
        universityDescriptionLabel.textAlignment = NSTextAlignment.Center
        universityDescriptionLabel.textColor = UIColor.blackColor()
        universityDescriptionLabel.font = UIFont.systemFontOfSize(8.5)
        universityDescriptionLabel.numberOfLines = 0
        
        
        let sourceLabel = UILabel(frame: CGRectMake(10,286,width - 20,11))
        sourceLabel.text = source
        sourceLabel.textAlignment = NSTextAlignment.Left
        sourceLabel.textColor = UIColor(colorLiteralRed: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        sourceLabel.font = UIFont.systemFontOfSize(7)
        sourceLabel.numberOfLines = 1
        
        let basic_info_board = UIImageView(frame: CGRectMake(8,315,width - 16,115))
        basic_info_board.image = UIImage(named: "basic_info_board")
        
        let basic_info_label = UILabel(frame: CGRectMake(width/2 - 34,323,68,21))
        basic_info_label.text = "基本信息"
        basic_info_label.textAlignment = NSTextAlignment.Center
        basic_info_label.textColor = UIColor.blackColor()
        basic_info_label.font = UIFont.systemFontOfSize(12.5)
        basic_info_label.numberOfLines = 1
        
        
        let fiveLabelDistanceUnit : CGFloat = (width - 19 - 12 - 7 - 11 - 14 - 12) / 5
        
        
        let oneYearTuitionTopLabel = UILabel(frame: CGRectMake(19,365,fiveLabelDistanceUnit,31))
        oneYearTuitionTopLabel.text = oneYearTuitionTop
        oneYearTuitionTopLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionTopLabel.textColor = UIColor.blackColor()
        oneYearTuitionTopLabel.font = UIFont.systemFontOfSize(15)
        oneYearTuitionTopLabel.numberOfLines = 0
        
        let numberOfStudentTopLabel = UILabel(frame: CGRectMake(19+12+fiveLabelDistanceUnit,365,fiveLabelDistanceUnit,31))
        numberOfStudentTopLabel.text = numberOfStudentTop
        numberOfStudentTopLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentTopLabel.textColor = UIColor.blackColor()
        numberOfStudentTopLabel.font = UIFont.systemFontOfSize(15)
        numberOfStudentTopLabel.numberOfLines = 0
        
        let overallRankingTopLabel = UILabel(frame: CGRectMake(19+12+7+fiveLabelDistanceUnit*2,365,fiveLabelDistanceUnit,31))
        overallRankingTopLabel.text = overallRankingTop
        overallRankingTopLabel.textAlignment = NSTextAlignment.Center
        overallRankingTopLabel.textColor = UIColor.blackColor()
        overallRankingTopLabel.font = UIFont.systemFontOfSize(15)
        overallRankingTopLabel.numberOfLines = 0
        
        let applicationDeadlineTopLabel = UILabel(frame: CGRectMake(19+12+7+11+fiveLabelDistanceUnit*3,365,fiveLabelDistanceUnit,31))
        applicationDeadlineTopLabel.text = applicationDeadlineTop
        applicationDeadlineTopLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineTopLabel.textColor = UIColor.blackColor()
        applicationDeadlineTopLabel.font = UIFont.systemFontOfSize(15)
        applicationDeadlineTopLabel.numberOfLines = 0
        applicationDeadlineTopLabel.minimumScaleFactor = 0.75
        
        
        let acceptenceRateLabel = UILabel(frame: CGRectMake(19+12+7+11+14+fiveLabelDistanceUnit*4,365,fiveLabelDistanceUnit,31))
        acceptenceRateLabel.text = acceptenceRate
        acceptenceRateLabel.textAlignment = NSTextAlignment.Center
        acceptenceRateLabel.textColor = UIColor.blackColor()
        acceptenceRateLabel.font = UIFont.systemFontOfSize(15)
        acceptenceRateLabel.numberOfLines = 0
        
        let oneYearTuitionBottomLabel = UILabel(frame: CGRectMake(19,406,fiveLabelDistanceUnit,13))
        oneYearTuitionBottomLabel.text = oneYearTuitionBottom
        oneYearTuitionBottomLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionBottomLabel.textColor = UIColor.blackColor()
        oneYearTuitionBottomLabel.font = UIFont.systemFontOfSize(11)
        oneYearTuitionBottomLabel.numberOfLines = 0
        
        let numberOfStudentBottomLabel = UILabel(frame: CGRectMake(19+12+fiveLabelDistanceUnit,406,fiveLabelDistanceUnit,13))
        numberOfStudentBottomLabel.text = numberOfStudentBottom
        numberOfStudentBottomLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentBottomLabel.textColor = UIColor.blackColor()
        numberOfStudentBottomLabel.font = UIFont.systemFontOfSize(11)
        numberOfStudentBottomLabel.numberOfLines = 0
        
        let overallRankingBottomLabel = UILabel(frame: CGRectMake(19+12+7+fiveLabelDistanceUnit*2,406,fiveLabelDistanceUnit,13))
        overallRankingBottomLabel.text = overallRankingBottom
        overallRankingBottomLabel.textAlignment = NSTextAlignment.Center
        overallRankingBottomLabel.textColor = UIColor.blackColor()
        overallRankingBottomLabel.font = UIFont.systemFontOfSize(11)
        overallRankingBottomLabel.numberOfLines = 0
        
        let applicationDeadlineBottomLabel = UILabel(frame: CGRectMake(19+12+7+11+fiveLabelDistanceUnit*3,406,fiveLabelDistanceUnit,13))
        applicationDeadlineBottomLabel.text = applicationDeadlineBottom
        applicationDeadlineBottomLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineBottomLabel.textColor = UIColor.blackColor()
        applicationDeadlineBottomLabel.font = UIFont.systemFontOfSize(11)
        applicationDeadlineBottomLabel.numberOfLines = 0
        
        let acceptenceRateBottomLabel = UILabel(frame: CGRectMake(19+12+7+11+14+fiveLabelDistanceUnit*4,406,fiveLabelDistanceUnit,13))
        acceptenceRateBottomLabel.text = applicationDeadlineBottom
        acceptenceRateBottomLabel.textAlignment = NSTextAlignment.Center
        acceptenceRateBottomLabel.textColor = UIColor.blackColor()
        acceptenceRateBottomLabel.font = UIFont.systemFontOfSize(11)
        acceptenceRateBottomLabel.numberOfLines = 0
        
        
        let applicationInfo_board_ImageView = UIImageView(frame: CGRectMake(8,436.5,width - 16,184))
        applicationInfo_board_ImageView.image = UIImage(named: "info_board_without_info_visualization")
        
        let applicationInfo_board_label = UILabel(frame: CGRectMake(width/2 - 34,442,68,21))
        applicationInfo_board_label.text = "申请信息"
        applicationInfo_board_label.textAlignment = NSTextAlignment.Center
        applicationInfo_board_label.textColor = UIColor.blackColor()
        applicationInfo_board_label.font = UIFont.systemFontOfSize(12.5)
        applicationInfo_board_label.numberOfLines = 1

        let applicationInfo_board_first_left_label = UILabel(frame: CGRectMake(47,475,109,21))
        applicationInfo_board_first_left_label.text = application_info_board_first_left
        applicationInfo_board_first_left_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_first_left_label.textColor = UIColor.blackColor()
        applicationInfo_board_first_left_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_first_left_label.numberOfLines = 0
        
        let applicationInfo_board_second_left_label = UILabel(frame: CGRectMake(47,475+21+9,109,21))
        applicationInfo_board_second_left_label.text = application_info_board_second_left
        applicationInfo_board_second_left_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_second_left_label.textColor = UIColor.blackColor()
        applicationInfo_board_second_left_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_second_left_label.numberOfLines = 0
        
        let applicationInfo_board_third_left_label = UILabel(frame: CGRectMake(47,475+21*2+18,109,21))
        applicationInfo_board_third_left_label.text = application_info_board_third_left
        applicationInfo_board_third_left_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_third_left_label.textColor = UIColor.blackColor()
        applicationInfo_board_third_left_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_third_left_label.numberOfLines = 0
        
        let applicationInfo_board_fourth_left_label = UILabel(frame: CGRectMake(47,475+27+21*3,109,21))
        applicationInfo_board_fourth_left_label.text = application_info_board_fourth_left
        applicationInfo_board_fourth_left_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_fourth_left_label.textColor = UIColor.blackColor()
        applicationInfo_board_fourth_left_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_fourth_left_label.numberOfLines = 0
        
        let applicationInfo_board_first_right_label = UILabel(frame: CGRectMake(width - 8 - 106,475,109,21))
        applicationInfo_board_first_right_label.text = application_info_board_first_right
        applicationInfo_board_first_right_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_first_right_label.textColor = UIColor.blackColor()
        applicationInfo_board_first_right_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_first_right_label.numberOfLines = 0
        
        let applicationInfo_board_second_right_label = UILabel(frame: CGRectMake(width - 8 - 106,475+21+9,109,21))
        applicationInfo_board_second_right_label.text = application_info_board_second_right
        applicationInfo_board_second_right_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_second_right_label.textColor = UIColor.blackColor()
        applicationInfo_board_second_right_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_second_right_label.numberOfLines = 0
        
        let applicationInfo_board_third_right_label = UILabel(frame: CGRectMake(width - 8 - 106,475+21*2+18,109,21))
        applicationInfo_board_third_right_label.text = application_info_board_third_right
        applicationInfo_board_third_right_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_third_right_label.textColor = UIColor.blackColor()
        applicationInfo_board_third_right_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_third_right_label.numberOfLines = 0
        
        let applicationInfo_board_fourth_right_label = UILabel(frame: CGRectMake(width - 8 - 106,475+27+21*3,109,21))
        applicationInfo_board_fourth_right_label.text = application_info_board_fourth_right
        applicationInfo_board_fourth_right_label.textAlignment = NSTextAlignment.Left
        applicationInfo_board_fourth_right_label.textColor = UIColor.blackColor()
        applicationInfo_board_fourth_right_label.font = UIFont.systemFontOfSize(11.5)
        applicationInfo_board_fourth_right_label.numberOfLines = 0
        
        
        let applicationMoreButton = UIButton(type: UIButtonType.Custom)
        applicationMoreButton.frame = CGRectMake(width/2 - 99/2,596,99,21)
        applicationMoreButton.setTitle("更多", forState: UIControlState.Normal)
        applicationMoreButton.setTitleColor(UIColor(colorLiteralRed: 0, green: 135/255, blue: 218/255, alpha: 0.75)
, forState: UIControlState.Normal)
        applicationMoreButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        applicationMoreButton.layer.borderColor = Utils.mainColor.CGColor
        applicationMoreButton.layer.borderWidth = 1
        applicationMoreButton.layer.cornerRadius = 10
        applicationMoreButton.clipsToBounds = true
        applicationMoreButton.tag = 1
        applicationMoreButton.addTarget(self, action: "touch:", forControlEvents: UIControlEvents.TouchUpInside)
        

        
        
        
        let ranking_info_board_ImageView = UIImageView(frame: CGRectMake(8,630,width - 16,194))
        ranking_info_board_ImageView.image = UIImage(named: "info_board_without_info_visualization")
        
        let ranking_info_board_label = UILabel(frame: CGRectMake(width/2 - 34,635.5,68,21))
        ranking_info_board_label.text = "排名信息"
        ranking_info_board_label.textAlignment = NSTextAlignment.Center
        ranking_info_board_label.textColor = UIColor.blackColor()
        ranking_info_board_label.font = UIFont.systemFontOfSize(12.5)
        ranking_info_board_label.numberOfLines = 1
        
        let ranking_info_board_first_left_label = UILabel(frame: CGRectMake(47,669.5,109,21))
        ranking_info_board_first_left_label.text = ranking_info_board_first_left
        ranking_info_board_first_left_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_first_left_label.textColor = UIColor.blackColor()
        ranking_info_board_first_left_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_first_left_label.numberOfLines = 0
        
        let ranking_info_board_second_left_label = UILabel(frame: CGRectMake(47,669.5+21+9,109,21))
        ranking_info_board_second_left_label.text = ranking_info_board_second_left
        ranking_info_board_second_left_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_second_left_label.textColor = UIColor.blackColor()
        ranking_info_board_second_left_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_second_left_label.numberOfLines = 0
        
        let ranking_info_board_third_left_label = UILabel(frame: CGRectMake(47,669.5+21*2+18,109,21))
        ranking_info_board_third_left_label.text = ranking_info_board_third_left
        ranking_info_board_third_left_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_third_left_label.textColor = UIColor.blackColor()
        ranking_info_board_third_left_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_third_left_label.numberOfLines = 0
        
        let ranking_info_board_fourth_left_label = UILabel(frame: CGRectMake(47,669.5+27+21*3,109,21))
        ranking_info_board_fourth_left_label.text = ranking_info_board_fourth_left
        ranking_info_board_fourth_left_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_fourth_left_label.textColor = UIColor.blackColor()
        ranking_info_board_fourth_left_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_fourth_left_label.numberOfLines = 0
        
        let ranking_info_board_first_right_label = UILabel(frame: CGRectMake(width - 8 - 106,669.5,109,21))
        ranking_info_board_first_right_label.text = ranking_info_board_first_right
        ranking_info_board_first_right_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_first_right_label.textColor = UIColor.blackColor()
        ranking_info_board_first_right_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_first_right_label.numberOfLines = 0
        
        let ranking_info_board_second_right_label = UILabel(frame: CGRectMake(width - 8 - 106,669.5+21+9,109,21))
        ranking_info_board_second_right_label.text = ranking_info_board_second_right
        ranking_info_board_second_right_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_second_right_label.textColor = UIColor.blackColor()
        ranking_info_board_second_right_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_second_right_label.numberOfLines = 0
        
        let ranking_info_board_third_right_label = UILabel(frame: CGRectMake(width - 8 - 106,669.5+21*2+18,109,21))
        ranking_info_board_third_right_label.text = ranking_info_board_third_right
        ranking_info_board_third_right_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_third_right_label.textColor = UIColor.blackColor()
        ranking_info_board_third_right_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_third_right_label.numberOfLines = 0
        
        let ranking_info_board_fourth_right_label = UILabel(frame: CGRectMake(width - 8 - 106,669.5+27+21*3,109,21))
        ranking_info_board_fourth_right_label.text = ranking_info_board_fourth_right
        ranking_info_board_fourth_right_label.textAlignment = NSTextAlignment.Left
        ranking_info_board_fourth_right_label.textColor = UIColor.blackColor()
        ranking_info_board_fourth_right_label.font = UIFont.systemFontOfSize(11.5)
        ranking_info_board_fourth_right_label.numberOfLines = 0
        
        
        let rankingMoreButton = UIButton(type: UIButtonType.Custom)
        rankingMoreButton.frame = CGRectMake(width/2 - 99/2,774.5 + 21,99,21)
        rankingMoreButton.setTitle("更多", forState: UIControlState.Normal)
        rankingMoreButton.tag = 0
        rankingMoreButton.setTitleColor(UIColor(colorLiteralRed: 0, green: 135/255, blue: 218/255, alpha: 0.75)
            , forState: UIControlState.Normal)
        rankingMoreButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        rankingMoreButton.layer.borderColor = Utils.mainColor.CGColor
        rankingMoreButton.layer.borderWidth = 1
        rankingMoreButton.layer.cornerRadius = 10
        rankingMoreButton.clipsToBounds = true
        rankingMoreButton.addTarget(self, action: "touch:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let academic_info_board_ImageView = UIImageView(frame: CGRectMake(8,831.5,width - 16,305))
        academic_info_board_ImageView.image = UIImage(named: "info_board_with_info_visualization")
        
        let academic_info_board_label = UILabel(frame: CGRectMake(width/2 - 34,820+20,68,21))
        academic_info_board_label.text = "学术信息"
        academic_info_board_label.textAlignment = NSTextAlignment.Center
        academic_info_board_label.textColor = UIColor.blackColor()
        academic_info_board_label.font = UIFont.systemFontOfSize(12.5)
        academic_info_board_label.numberOfLines = 1
        
        let academic_info_board_first_left_label = UILabel(frame: CGRectMake(47,824+50,109,21))
        academic_info_board_first_left_label.text = academic_info_board_first_left
        academic_info_board_first_left_label.textAlignment = NSTextAlignment.Left
        academic_info_board_first_left_label.textColor = UIColor.blackColor()
        academic_info_board_first_left_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_first_left_label.numberOfLines = 0
        
        let academic_info_board_second_left_label = UILabel(frame: CGRectMake(47,874+21+14,109,21))
        academic_info_board_second_left_label.text = academic_info_board_second_left
        academic_info_board_second_left_label.textAlignment = NSTextAlignment.Left
        academic_info_board_second_left_label.textColor = UIColor.blackColor()
        academic_info_board_second_left_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_second_left_label.numberOfLines = 0
        
        let academic_info_board_third_left_label = UILabel(frame: CGRectMake(47,874+21*2+28,109,21))
        academic_info_board_third_left_label.text = academic_info_board_third_left
        academic_info_board_third_left_label.textAlignment = NSTextAlignment.Left
        academic_info_board_third_left_label.textColor = UIColor.blackColor()
        academic_info_board_third_left_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_third_left_label.numberOfLines = 0
        
        let academic_info_board_fourth_left_label = UILabel(frame: CGRectMake(47,874+21*3+42,109,21))
        academic_info_board_fourth_left_label.text = academic_info_board_fourth_left
        academic_info_board_fourth_left_label.textAlignment = NSTextAlignment.Left
        academic_info_board_fourth_left_label.textColor = UIColor.blackColor()
        academic_info_board_fourth_left_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_fourth_left_label.numberOfLines = 0
        
        let academic_info_board_first_right_label = UILabel(frame: CGRectMake(width - 8 - 106,874,109,21))
        academic_info_board_first_right_label.text = academic_info_board_first_right
        academic_info_board_first_right_label.textAlignment = NSTextAlignment.Left
        academic_info_board_first_right_label.textColor = UIColor.blackColor()
        academic_info_board_first_right_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_first_right_label.numberOfLines = 0
        
        let academic_info_board_second_right_label = UILabel(frame: CGRectMake(width - 8 - 106,874+21+14,109,21))
        academic_info_board_second_right_label.text = academic_info_board_second_right
        academic_info_board_second_right_label.textAlignment = NSTextAlignment.Left
        academic_info_board_second_right_label.textColor = UIColor.blackColor()
        academic_info_board_second_right_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_second_right_label.numberOfLines = 0
        
        let academic_info_board_third_right_label = UILabel(frame: CGRectMake(width - 8 - 106,874+21*2+28,109,21))
        academic_info_board_third_right_label.text = academic_info_board_third_right
        academic_info_board_third_right_label.textAlignment = NSTextAlignment.Left
        academic_info_board_third_right_label.textColor = UIColor.blackColor()
        academic_info_board_third_right_label.font = UIFont.systemFontOfSize(11.5)
        academic_info_board_third_right_label.numberOfLines = 0
        
        
        let academicMoreButton = UIButton(type: UIButtonType.Custom)
        academicMoreButton.frame = CGRectMake(width/2 - 99/2,1110.5,99,21)
        academicMoreButton.tag = 2
        academicMoreButton.setTitle("更多", forState: UIControlState.Normal)
        academicMoreButton.setTitleColor(UIColor(colorLiteralRed: 0, green: 135/255, blue: 218/255, alpha: 0.75)
            , forState: UIControlState.Normal)
        academicMoreButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        academicMoreButton.layer.borderColor = Utils.mainColor.CGColor
        academicMoreButton.layer.borderWidth = 1
        academicMoreButton.layer.cornerRadius = 10
        academicMoreButton.clipsToBounds = true
        academicMoreButton.addTarget(self, action: "touch:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let cost_info_board_ImageView = UIImageView(frame: CGRectMake(8,1136+13,width - 16,205))
        cost_info_board_ImageView.image = UIImage(named: "info_board_without_info_visualization")
        
        let cost_info_board_label = UILabel(frame: CGRectMake(width/2 - 85/2,1136+17,85,22))
        cost_info_board_label.text = "花费及赞助"
        cost_info_board_label.textAlignment = NSTextAlignment.Center
        cost_info_board_label.textColor = UIColor.blackColor()
        cost_info_board_label.font = UIFont.systemFontOfSize(12.5)
        cost_info_board_label.numberOfLines = 1
        
        let cost_info_board_first_left_label = UILabel(frame: CGRectMake(47,1174+14,109,21))
        cost_info_board_first_left_label.text = cost_info_board_first_left
        cost_info_board_first_left_label.textAlignment = NSTextAlignment.Left
        cost_info_board_first_left_label.textColor = UIColor.blackColor()
        cost_info_board_first_left_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_first_left_label.numberOfLines = 0
        
        let cost_info_board_second_left_label = UILabel(frame: CGRectMake(47,1174+21+14*2,109,21))
        cost_info_board_second_left_label.text = cost_info_board_second_left
        cost_info_board_second_left_label.textAlignment = NSTextAlignment.Left
        cost_info_board_second_left_label.textColor = UIColor.blackColor()
        cost_info_board_second_left_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_second_left_label.numberOfLines = 0
        
        let cost_info_board_third_left_label = UILabel(frame: CGRectMake(47,1174+21*2+14*3,109,21))
        cost_info_board_third_left_label.text = cost_info_board_third_left
        cost_info_board_third_left_label.textAlignment = NSTextAlignment.Left
        cost_info_board_third_left_label.textColor = UIColor.blackColor()
        cost_info_board_third_left_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_third_left_label.numberOfLines = 0
        
        let cost_info_board_fourth_left_label = UILabel(frame: CGRectMake(47,1174+21*3+14*4 ,109,21))
        cost_info_board_fourth_left_label.text = cost_info_board_fourth_left
        cost_info_board_fourth_left_label.textAlignment = NSTextAlignment.Left
        cost_info_board_fourth_left_label.textColor = UIColor.blackColor()
        cost_info_board_fourth_left_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_fourth_left_label.numberOfLines = 0
        
        let cost_info_board_first_right_label = UILabel(frame: CGRectMake(width - 8 - 106,1174+14,109,21))
        cost_info_board_first_right_label.text = cost_info_board_first_right
        cost_info_board_first_right_label.textAlignment = NSTextAlignment.Left
        cost_info_board_first_right_label.textColor = UIColor.blackColor()
        cost_info_board_first_right_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_first_right_label.numberOfLines = 0
        
        let cost_info_board_second_right_label = UILabel(frame: CGRectMake(width - 8 - 106,1174+21+14*2,109,21))
        cost_info_board_second_right_label.text = cost_info_board_second_right
        cost_info_board_second_right_label.textAlignment = NSTextAlignment.Left
        cost_info_board_second_right_label.textColor = UIColor.blackColor()
        cost_info_board_second_right_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_second_right_label.numberOfLines = 0
        
        let cost_info_board_third_right_label = UILabel(frame: CGRectMake(width - 8 - 106,1174+21*2+14*3,109,21))
        cost_info_board_third_right_label.text = cost_info_board_third_right
        cost_info_board_third_right_label.textAlignment = NSTextAlignment.Left
        cost_info_board_third_right_label.textColor = UIColor.blackColor()
        cost_info_board_third_right_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_third_right_label.numberOfLines = 0
        
        let cost_info_board_fourth_right_label = UILabel(frame: CGRectMake(width - 8 - 106,1174+21*3+14*4,109,21))
        cost_info_board_fourth_right_label.text = cost_info_board_fourth_right
        cost_info_board_fourth_right_label.textAlignment = NSTextAlignment.Left
        cost_info_board_fourth_right_label.textColor = UIColor.blackColor()
        cost_info_board_fourth_right_label.font = UIFont.systemFontOfSize(11.5)
        cost_info_board_fourth_right_label.numberOfLines = 0

        
        let costMoreButton = UIButton(type: UIButtonType.Custom)
        costMoreButton.frame = CGRectMake(width/2 - 99/2,1293+21+13,99,21)
        costMoreButton.tag = 3
        costMoreButton.setTitle("更多", forState: UIControlState.Normal)
        costMoreButton.setTitleColor(UIColor(colorLiteralRed: 0, green: 135/255, blue: 218/255, alpha: 0.75)
            , forState: UIControlState.Normal)
        costMoreButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        costMoreButton.layer.borderColor = Utils.mainColor.CGColor
        costMoreButton.layer.borderWidth = 1
        costMoreButton.layer.cornerRadius = 10
        costMoreButton.clipsToBounds = true
        costMoreButton.addTarget(self, action: "touch:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(cost_info_board_ImageView.frame) + 10)
       
        
        
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(universityChineseNameLabel)
        scrollView.addSubview(universityEnglishNameLabel)
        scrollView.addSubview(universityLocationLabel)
        scrollView.addSubview(universityDescriptionLabel)
        scrollView.addSubview(sourceLabel)
        
        scrollView.addSubview(basic_info_board)
        scrollView.addSubview(basic_info_label)
        scrollView.addSubview(acceptenceRateLabel)
        scrollView.addSubview(oneYearTuitionTopLabel)
        scrollView.addSubview(numberOfStudentTopLabel)
        scrollView.addSubview(overallRankingTopLabel)
        scrollView.addSubview(applicationDeadlineTopLabel)
        scrollView.addSubview(oneYearTuitionBottomLabel)
        scrollView.addSubview(numberOfStudentBottomLabel)
        scrollView.addSubview(overallRankingBottomLabel)
        scrollView.addSubview(applicationDeadlineBottomLabel)
        scrollView.addSubview(acceptenceRateBottomLabel)
        
        
        scrollView.addSubview(applicationInfo_board_ImageView)
        scrollView.addSubview(applicationInfo_board_label)
        scrollView.addSubview(applicationInfo_board_first_left_label)
        scrollView.addSubview(applicationInfo_board_second_left_label)
        scrollView.addSubview(applicationInfo_board_third_left_label)
        scrollView.addSubview(applicationInfo_board_fourth_left_label)
        scrollView.addSubview(applicationInfo_board_first_right_label)
        scrollView.addSubview(applicationInfo_board_second_right_label)
        scrollView.addSubview(applicationInfo_board_third_right_label)
        scrollView.addSubview(applicationInfo_board_fourth_right_label)
        scrollView.addSubview(applicationMoreButton)
        
        scrollView.addSubview(ranking_info_board_ImageView)
        scrollView.addSubview(ranking_info_board_label)
        scrollView.addSubview(ranking_info_board_first_left_label)
        scrollView.addSubview(ranking_info_board_second_left_label)
        scrollView.addSubview(ranking_info_board_third_left_label)
        scrollView.addSubview(ranking_info_board_fourth_left_label)
        scrollView.addSubview(ranking_info_board_first_right_label)
        scrollView.addSubview(ranking_info_board_second_right_label)
        scrollView.addSubview(ranking_info_board_third_right_label)
        scrollView.addSubview(ranking_info_board_fourth_right_label)
        scrollView.addSubview(rankingMoreButton)
        
        scrollView.addSubview(academic_info_board_ImageView)
        scrollView.addSubview(academic_info_board_label)
        scrollView.addSubview(academic_info_board_first_left_label)
        scrollView.addSubview(academic_info_board_second_left_label)
        scrollView.addSubview(academic_info_board_third_left_label)
        scrollView.addSubview(academic_info_board_fourth_left_label)
        scrollView.addSubview(academic_info_board_first_right_label)
        scrollView.addSubview(academic_info_board_second_right_label)
        scrollView.addSubview(academic_info_board_third_right_label)
        scrollView.addSubview(academicMoreButton)
        
        
        scrollView.addSubview(cost_info_board_ImageView)
        scrollView.addSubview(cost_info_board_label)
        scrollView.addSubview(cost_info_board_first_left_label)
        scrollView.addSubview(cost_info_board_second_left_label)
        scrollView.addSubview(cost_info_board_third_left_label)
        scrollView.addSubview(cost_info_board_fourth_left_label)
        scrollView.addSubview(cost_info_board_first_right_label)
        scrollView.addSubview(cost_info_board_second_right_label)
        scrollView.addSubview(cost_info_board_third_right_label)
        scrollView.addSubview(cost_info_board_fourth_right_label)
        scrollView.addSubview(costMoreButton)
        
        
//        let storyboardView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("OverviewSchoolTabViewController")
//        
//
//        
//        presentingView.addSubview(storyboardView.view)
//        
        
        
//        let blurImage: UIImage = UIImage(named: "LoginBackground")!
//        presentingView.layer.contents = blurImage.CGImage
        scrollView.backgroundColor = UIColor.whiteColor()
        presentingView.backgroundColor = UIColor.blackColor()
        presentingView.addSubview(scrollView)
        
    }
    
    
    func touch(button:UIButton){
        self.selectedUniversity = self.universityArray[0]
        Tool.showProgressHUD("正在加载")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let path = NSBundle.mainBundle().pathForResource(self.selectedUniversity?.name, ofType: "plist")
            let data : NSDictionary = NSDictionary(contentsOfFile: path!)!
            self.collegeDetail = Tool.parseJsonAndReturnCollegeDetail(data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                Tool.dismissHUD()
                switch button.tag {
                case 0:
                    self.performSegueWithIdentifier("toRanking", sender: self)
                case 1:
                    self.performSegueWithIdentifier("toApplication", sender: self)
                case 2:
                    self.performSegueWithIdentifier("toAcademic", sender: self)
                case 3:
                    self.performSegueWithIdentifier("toCost", sender: self)
                default:
                    break
                }
                
            })
        })
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupLeftMenuButton()
    {
        let image = UIImage(named: "left button")
        let leftDrawerButton = UIButton(frame: CGRectMake(0, 0, 25, 25))
        leftDrawerButton.setBackgroundImage(image, forState: UIControlState.Normal)
        
        leftDrawerButton.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        //        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        //self.cardViewController.dismissButton = leftDrawerButton
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toUniversity" {
            let tab = segue.destinationViewController as! OverviewSchoolTabViewController
            tab.collegeDetail = self.collegeDetail
            
        } else if segue.identifier == "toRanking" {
            let vc = segue.destinationViewController as! SchoolRankingViewController
            vc.collegeRanking = self.collegeDetail!.collegeRanking
            vc.source = "mySchool"
        } else if segue.identifier == "toApplication" {
            let vc = segue.destinationViewController as! SchoolApplicationViewController
            vc.collegeApplication = self.collegeDetail!.collegeApplying
            vc.source = "mySchool"
        } else if segue.identifier == "toCost" {
            let vc = segue.destinationViewController as! SchoolCostViewController
            vc.collegeCost = self.collegeDetail!.collegeFinancial
            vc.source = "mySchool"
        } else if segue.identifier == "toAcademic" {
            let vc = segue.destinationViewController as! SchoolAcademicViewController
            vc.collegeAcademic = self.collegeDetail!.collegeAcademic
            vc.source = "mySchool"
        }
    }
    
    
    
}

//
//  SchoolCardCollectionViewCell.swift
//  ziliuxue
//
//  Created by Gelei Chen on 28/10/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit


class SchoolCardCollectionViewCell: UICollectionViewCell {
    
    var backgroundImageName = "University of Chicago photo2"
    var avatarImageName = "Stanford University logo"
    var universityChineseName = "普林斯顿大学"
    var universityEnglishName = "Princeton University"
    var universityLocation = "TROY.MIasdasdasdasdas"
    var universityDescription = "普林斯顿大学是美国一所享誉世界的顶尖私立研究型大学，位于美国新泽西州的普林斯顿，八所常春藤盟校之一。学校于1746年在新泽西州伊丽莎白镇创立，是美国殖民时期第四所成立的高等教育学院，当时名为“新泽西学院”，并在1896年正式改名为普林斯顿大学。"
    var oneYearTuitionTop = "$41,820"
    var numberOfStudentTop = "#1"
    var overallRankingTop = "1月1日"
    var applicationDeadlineTop = "7.4%"
    
    
    var phoneNumber = "+1 (609) 258-3000"
    var email = "uaoffice@princeton.edu"
    var mail = "PO Box 403, Princetion, NJ 08544"
    var fax = "+1 (765) 494-0544"
    
    let oneYearTuitionBottom = "一年学费"
    let numberOfStudentBottom = "综合排名"
    let overallRankingBottom = "截止申请"
    let applicationDeadlineBottom = "申请接受率"
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = self.frame.width
        let infoCardImageView = UIImageView(frame: CGRectMake(0, 0, width, self.frame.height))
        if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P{
            infoCardImageView.image = UIImage(named: "school basic info card-6")
        } else if DeviceType.IS_IPHONE_5 {
            infoCardImageView.image = UIImage(named: "school basic info card-5 5s")
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            infoCardImageView.image = UIImage(named: "school basic info card-4 4s")
        }
        
        let backgroundImageView = UIImageView(frame: CGRectMake(0, 0, width, 230))
        backgroundImageView.image = UIImage(named: backgroundImageName)
        backgroundImageView.contentMode = UIViewContentMode.ScaleToFill
        
        
        let blurView = UIView(frame: CGRectMake(0, 0, width, 230))
        blurView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        
        
        let topRightImageViewButton = UIButton(type: UIButtonType.Custom)
        topRightImageViewButton.frame = CGRectMake(width - 55, 0, 55, 51)
        topRightImageViewButton.setImage(UIImage(named: "favourite_active"), forState: UIControlState.Normal)
        topRightImageViewButton.addTarget(self, action: "topRightImageViewButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        let avatarImageView = UIImageView(frame: CGRectMake(width / 2 - 37.5,43,75,75))
        avatarImageView.image = UIImage(named: avatarImageName)
        
        let universityChineseNameLabel = UILabel(frame: CGRectMake(23,142,width - (23 * 2),22))
        universityChineseNameLabel.text = universityChineseName
        universityChineseNameLabel.textAlignment = NSTextAlignment.Center
        universityChineseNameLabel.textColor = UIColor.whiteColor()
        universityChineseNameLabel.font = UIFont.systemFontOfSize(22)
        
        
        let universityEnglishNameLabel = UILabel(frame: CGRectMake(23,142+22+7.5,width - (23 * 2),15))
        universityEnglishNameLabel.text = universityEnglishName
        universityEnglishNameLabel.textAlignment = NSTextAlignment.Center
        universityEnglishNameLabel.textColor = UIColor.whiteColor()
        universityEnglishNameLabel.font = UIFont(name: "Avenir-Light", size: 15)
        
        let universityLocationLabel = UILabel(frame: CGRectMake(width / 2 - 45 + 10 + 4,180.5+17.5,100,12))
        universityLocationLabel.text = universityLocation
        universityLocationLabel.textAlignment = NSTextAlignment.Center
        universityLocationLabel.textColor = UIColor.whiteColor()
        universityLocationLabel.font = UIFont(name: "Avenir-Light", size: 12)
        universityLocationLabel.numberOfLines = 1
        universityLocationLabel.adjustsFontSizeToFitWidth = true
        
        
        
        let universityLocationImageView = UIImageView(frame: CGRectMake(width / 2 - 45,180.5+17.5,10,10))
        universityLocationImageView.image = UIImage(named: "location")
        
        
        let universityDescriptionLabel = UILabel(frame: CGRectMake(28,220,width - 56,100))
        universityDescriptionLabel.text = universityDescription
        universityDescriptionLabel.textAlignment = NSTextAlignment.Center
        universityDescriptionLabel.textColor = UIColor.blackColor()
        universityDescriptionLabel.font = UIFont.systemFontOfSize(11)
        universityDescriptionLabel.numberOfLines = 3
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        
        let attrString = NSMutableAttributedString(string: universityDescription)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        universityDescriptionLabel.attributedText = attrString
        
        
        let fourLabelDistanceUnit = width / 4
        
        
        let oneYearTuitionTopLabel = UILabel(frame: CGRectMake(0,310,fourLabelDistanceUnit,40))
        oneYearTuitionTopLabel.text = oneYearTuitionTop
        oneYearTuitionTopLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionTopLabel.textColor = UIColor.blackColor()
        oneYearTuitionTopLabel.font = UIFont.systemFontOfSize(14)
        oneYearTuitionTopLabel.numberOfLines = 0
        
        let numberOfStudentTopLabel = UILabel(frame: CGRectMake(fourLabelDistanceUnit,310,fourLabelDistanceUnit,40))
        numberOfStudentTopLabel.text = numberOfStudentTop
        numberOfStudentTopLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentTopLabel.textColor = UIColor.blackColor()
        numberOfStudentTopLabel.font = UIFont.systemFontOfSize(14)
        numberOfStudentTopLabel.numberOfLines = 0

        let overallRankingTopLabel = UILabel(frame: CGRectMake(2*fourLabelDistanceUnit,310,fourLabelDistanceUnit,40))
        overallRankingTopLabel.text = overallRankingTop
        overallRankingTopLabel.textAlignment = NSTextAlignment.Center
        overallRankingTopLabel.textColor = UIColor.blackColor()
        overallRankingTopLabel.font = UIFont.systemFontOfSize(14)
        overallRankingTopLabel.numberOfLines = 0

        let applicationDeadlineTopLabel = UILabel(frame: CGRectMake(3*fourLabelDistanceUnit,310,fourLabelDistanceUnit,40))
        applicationDeadlineTopLabel.text = applicationDeadlineTop
        applicationDeadlineTopLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineTopLabel.textColor = UIColor.blackColor()
        applicationDeadlineTopLabel.font = UIFont.systemFontOfSize(14)
        applicationDeadlineTopLabel.numberOfLines = 0

        let oneYearTuitionBottomLabel = UILabel(frame: CGRectMake(0,342,fourLabelDistanceUnit,18))
        oneYearTuitionBottomLabel.text = oneYearTuitionBottom
        oneYearTuitionBottomLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionBottomLabel.textColor = UIColor.blackColor()
        oneYearTuitionBottomLabel.font = UIFont.systemFontOfSize(9)
        oneYearTuitionBottomLabel.numberOfLines = 0
        
        let numberOfStudentBottomLabel = UILabel(frame: CGRectMake(fourLabelDistanceUnit,342,fourLabelDistanceUnit,18))
        numberOfStudentBottomLabel.text = numberOfStudentBottom
        numberOfStudentBottomLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentBottomLabel.textColor = UIColor.blackColor()
        numberOfStudentBottomLabel.font = UIFont.systemFontOfSize(9)
        numberOfStudentBottomLabel.numberOfLines = 0
        
        let overallRankingBottomLabel = UILabel(frame: CGRectMake(2*fourLabelDistanceUnit,342,fourLabelDistanceUnit,18))
        overallRankingBottomLabel.text = overallRankingBottom
        overallRankingBottomLabel.textAlignment = NSTextAlignment.Center
        overallRankingBottomLabel.textColor = UIColor.blackColor()
        overallRankingBottomLabel.font = UIFont.systemFontOfSize(9)
        overallRankingBottomLabel.numberOfLines = 0
        
        let applicationDeadlineBottomLabel = UILabel(frame: CGRectMake(3*fourLabelDistanceUnit,342,fourLabelDistanceUnit,18))
        applicationDeadlineBottomLabel.text = applicationDeadlineBottom
        applicationDeadlineBottomLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineBottomLabel.textColor = UIColor.blackColor()
        applicationDeadlineBottomLabel.font = UIFont.systemFontOfSize(9)
        applicationDeadlineBottomLabel.numberOfLines = 0

        
        
        
        
        self.addSubview(infoCardImageView)
        self.addSubview(backgroundImageView)
        self.addSubview(blurView)
        self.addSubview(topRightImageViewButton)
        self.addSubview(avatarImageView)
        self.addSubview(universityChineseNameLabel)
        self.addSubview(universityEnglishNameLabel)
        self.addSubview(universityLocationLabel)
        self.addSubview(universityLocationImageView)
        self.addSubview(universityDescriptionLabel)
        self.addSubview(oneYearTuitionTopLabel)
        self.addSubview(numberOfStudentTopLabel)
        self.addSubview(overallRankingTopLabel)
        self.addSubview(applicationDeadlineTopLabel)
        self.addSubview(oneYearTuitionBottomLabel)
        self.addSubview(numberOfStudentBottomLabel)
        self.addSubview(overallRankingBottomLabel)
        self.addSubview(applicationDeadlineBottomLabel)
        
        let height = self.frame.height
        
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            let remainingCellHeight = height - 342 - 10
            let phoneImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight/2 + 1,13,13))
            phoneImageView.image = UIImage(named: "电话")
            
            let phoneLabel = UILabel(frame: CGRectMake(15+13+5,height - remainingCellHeight/2,width / 2 - 15 - 13 - 5 + 1,13))
            phoneLabel.text = phoneNumber
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.textColor = UIColor.blackColor()
            phoneLabel.font = UIFont.systemFontOfSize(10)
            phoneLabel.numberOfLines = 1
            
            let emailImageView = UIImageView(frame: CGRectMake(width / 2 + 15,height - remainingCellHeight/2,13,13))
            emailImageView.image = UIImage(named: "邮件")
            
            let emailLabel = UILabel(frame: CGRectMake(width / 2 + 15+13+5,height - remainingCellHeight/2 - 10 ,width / 2 - 30,30))
            emailLabel.text = email
            emailLabel.textAlignment = NSTextAlignment.Left
            emailLabel.textColor = UIColor.blackColor()
            emailLabel.font = UIFont.systemFontOfSize(10)
            emailLabel.numberOfLines = 2
            
            
            self.addSubview(phoneLabel)
            self.addSubview(phoneImageView)
            self.addSubview(emailImageView)
            self.addSubview(emailLabel)
        } else if DeviceType.IS_IPHONE_5 {
            let remainingCellHeight = CGFloat(130)
            let center = CGFloat(9)
            let phoneImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center,13,13))
            phoneImageView.image = UIImage(named: "电话")
            
            let phoneLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center ,width - 15 - 13 - 5,13))
            phoneLabel.text = phoneNumber
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.textColor = UIColor.blackColor()
            phoneLabel.font = UIFont.systemFontOfSize(10)
            phoneLabel.numberOfLines = 1
            
            let emailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32,13,13))
            emailImageView.image = UIImage(named: "邮件")
            
            let emailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 ,width - 15 - 13 - 5,13))
            emailLabel.text = email
            emailLabel.textAlignment = NSTextAlignment.Left
            emailLabel.textColor = UIColor.blackColor()
            emailLabel.font = UIFont.systemFontOfSize(10)
            emailLabel.numberOfLines = 2
            
            let mailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32 * 2,13,13))
            mailImageView.image = UIImage(named: "mail")
            
            let mailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 * 2,width - 15 - 13 - 5,13))
            mailLabel.text = mail
            mailLabel.textAlignment = NSTextAlignment.Left
            mailLabel.textColor = UIColor.blackColor()
            mailLabel.font = UIFont.systemFontOfSize(10)
            mailLabel.numberOfLines = 1
            
            let faxImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32*3,13,13))
            faxImageView.image = UIImage(named: "传真机")
            
            let faxLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32*3,width - 15 - 13 - 5,13))
            faxLabel.text = fax
            faxLabel.textAlignment = NSTextAlignment.Left
            faxLabel.textColor = UIColor.blackColor()
            faxLabel.font = UIFont.systemFontOfSize(10)
            faxLabel.numberOfLines = 2

            
            
            self.addSubview(phoneLabel)
            self.addSubview(phoneImageView)
            self.addSubview(emailImageView)
            self.addSubview(emailLabel)

            self.addSubview(mailLabel)
            self.addSubview(mailImageView)
            self.addSubview(faxImageView)
            self.addSubview(faxLabel)
            
            
        } else if DeviceType.IS_IPHONE_6 {
            
            let remainingCellHeight = CGFloat(230)
            let center = CGFloat(9)
            let phoneImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center,13,13))
            phoneImageView.image = UIImage(named: "电话")
            
            let phoneLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center ,width - 15 - 13 - 5,13))
            phoneLabel.text = phoneNumber
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.textColor = UIColor.blackColor()
            phoneLabel.font = UIFont.systemFontOfSize(10)
            phoneLabel.numberOfLines = 1
            
            let emailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32,13,13))
            emailImageView.image = UIImage(named: "邮件")
            
            let emailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 ,width - 15 - 13 - 5,13))
            emailLabel.text = email
            emailLabel.textAlignment = NSTextAlignment.Left
            emailLabel.textColor = UIColor.blackColor()
            emailLabel.font = UIFont.systemFontOfSize(10)
            emailLabel.numberOfLines = 2
            
            let mailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32 * 2,13,13))
            mailImageView.image = UIImage(named: "mail")
            
            let mailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 * 2,width - 15 - 13 - 5,13))
            mailLabel.text = mail
            mailLabel.textAlignment = NSTextAlignment.Left
            mailLabel.textColor = UIColor.blackColor()
            mailLabel.font = UIFont.systemFontOfSize(10)
            mailLabel.numberOfLines = 1
            
            let faxImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32*3,13,13))
            faxImageView.image = UIImage(named: "传真机")
            
            let faxLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32*3,width - 15 - 13 - 5,13))
            faxLabel.text = fax
            faxLabel.textAlignment = NSTextAlignment.Left
            faxLabel.textColor = UIColor.blackColor()
            faxLabel.font = UIFont.systemFontOfSize(10)
            faxLabel.numberOfLines = 2
            
            
            let similarSchoolLabel = UILabel(frame: CGRectMake(width/2 - 30,height - 100 + 10,60,13))
            similarSchoolLabel.text = "相似学校"
            similarSchoolLabel.textAlignment = NSTextAlignment.Center
            similarSchoolLabel.textColor = UIColor.blackColor()
            similarSchoolLabel.font = UIFont.systemFontOfSize(12.5)
            similarSchoolLabel.numberOfLines = 1
            
            print(width)
            
            let schoolImageView1 = UIImageView(frame: CGRectMake(25,height - 100 + 20 + 13,50,50))
            schoolImageView1.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView2 = UIImageView(frame: CGRectMake(25 + 50 + 28,height - 100 + 20 + 13,50,50))
            schoolImageView2.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView3 = UIImageView(frame: CGRectMake(25 + 50*2 + 28*2 ,height - 100 + 20 + 13,50,50))
            schoolImageView3.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView4 = UIImageView(frame: CGRectMake(25 + 50*3 + 28*3 ,height - 100 + 20 + 13,50,50))
            schoolImageView4.image = UIImage(named: "Stanford University logo")
            
            
            
            
            self.addSubview(phoneLabel)
            self.addSubview(phoneImageView)
            self.addSubview(emailImageView)
            self.addSubview(emailLabel)
            
            self.addSubview(mailLabel)
            self.addSubview(mailImageView)
            self.addSubview(faxImageView)
            self.addSubview(faxLabel)
            self.addSubview(similarSchoolLabel)
            
            self.addSubview(schoolImageView1)
            self.addSubview(schoolImageView2)
            self.addSubview(schoolImageView3)
            self.addSubview(schoolImageView4)
            
        } else if DeviceType.IS_IPHONE_6P {
            
            let remainingCellHeight = CGFloat(230)
            let center = CGFloat(9)
            let phoneImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center,13,13))
            phoneImageView.image = UIImage(named: "电话")
            
            let phoneLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center ,width - 15 - 13 - 5,13))
            phoneLabel.text = phoneNumber
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.textColor = UIColor.blackColor()
            phoneLabel.font = UIFont.systemFontOfSize(10)
            phoneLabel.numberOfLines = 1
            
            let emailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32,13,13))
            emailImageView.image = UIImage(named: "邮件")
            
            let emailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 ,width - 15 - 13 - 5,13))
            emailLabel.text = email
            emailLabel.textAlignment = NSTextAlignment.Left
            emailLabel.textColor = UIColor.blackColor()
            emailLabel.font = UIFont.systemFontOfSize(10)
            emailLabel.numberOfLines = 2
            
            let mailImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32 * 2,13,13))
            mailImageView.image = UIImage(named: "mail")
            
            let mailLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32 * 2,width - 15 - 13 - 5,13))
            mailLabel.text = mail
            mailLabel.textAlignment = NSTextAlignment.Left
            mailLabel.textColor = UIColor.blackColor()
            mailLabel.font = UIFont.systemFontOfSize(10)
            mailLabel.numberOfLines = 1
            
            let faxImageView = UIImageView(frame: CGRectMake(15,height - remainingCellHeight + center + 32*3,13,13))
            faxImageView.image = UIImage(named: "传真机")
            
            let faxLabel = UILabel(frame: CGRectMake(15+13+15,height - remainingCellHeight + center + 32*3,width - 15 - 13 - 5,13))
            faxLabel.text = fax
            faxLabel.textAlignment = NSTextAlignment.Left
            faxLabel.textColor = UIColor.blackColor()
            faxLabel.font = UIFont.systemFontOfSize(10)
            faxLabel.numberOfLines = 2
            
            
            let similarSchoolLabel = UILabel(frame: CGRectMake(width/2 - 30,height - 100 + 10,60,13))
            similarSchoolLabel.text = "相似学校"
            similarSchoolLabel.textAlignment = NSTextAlignment.Center
            similarSchoolLabel.textColor = UIColor.blackColor()
            similarSchoolLabel.font = UIFont.systemFontOfSize(12.5)
            similarSchoolLabel.numberOfLines = 1
            
            print(width)
            
            let schoolImageView1 = UIImageView(frame: CGRectMake(25,height - 100 + 20 + 13,50,50))
            schoolImageView1.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView2 = UIImageView(frame: CGRectMake(25 + 50 + 28,height - 100 + 20 + 13,50,50))
            schoolImageView2.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView3 = UIImageView(frame: CGRectMake(25 + 50*2 + 28*2 ,height - 100 + 20 + 13,50,50))
            schoolImageView3.image = UIImage(named: "Stanford University logo")
            
            let schoolImageView4 = UIImageView(frame: CGRectMake(25 + 50*3 + 28*3 ,height - 100 + 20 + 13,50,50))
            schoolImageView4.image = UIImage(named: "Stanford University logo")
            
            
            
            
            self.addSubview(phoneLabel)
            self.addSubview(phoneImageView)
            self.addSubview(emailImageView)
            self.addSubview(emailLabel)
            
            self.addSubview(mailLabel)
            self.addSubview(mailImageView)
            self.addSubview(faxImageView)
            self.addSubview(faxLabel)
            self.addSubview(similarSchoolLabel)
            
            self.addSubview(schoolImageView1)
            self.addSubview(schoolImageView2)
            self.addSubview(schoolImageView3)
            self.addSubview(schoolImageView4)
        }
        
        
    }
    
    func topRightImageViewButtonTouched(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
}

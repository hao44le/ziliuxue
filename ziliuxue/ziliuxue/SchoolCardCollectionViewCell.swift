//
//  SchoolCardCollectionViewCell.swift
//  ziliuxue
//
//  Created by Gelei Chen on 28/10/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit
import Charts

class SchoolCardCollectionViewCell: UICollectionViewCell {
    
    var backgroundImageName = "University of Chicago photo2"
    var avatarImageName = "University of Chicago logo"
    var universityChineseName = "普林斯顿大学"
    var universityEnglishName = "Princeton University"
    var universityLocation = "Monstroopolis, SW"
    var universityDescription = "普林斯顿大学是美国一所享誉世界的顶尖私立研究型大学，位于美国新泽西州的普林斯顿，八所常春藤盟校之一。学校于1746年在新泽西州伊丽莎白镇创立，是美国殖民时期第四所成立的高等教育学院，当时名为“新泽西学院”，并在1896年正式改名为普林斯顿大学。"
    var oneYearTuitionTop = "$41,820"
    var numberOfStudentTop = "5,323"
    var overallRankingTop = "#1"
    var applicationDeadlineTop = "1月1日"
    var mult : UInt32 = 100
    let count = 4
    let parties  = [
        "计算机科学", "插画专业", "应用物理", "统计学专业", "平面设计"
    ]
    
    
    
    let oneYearTuitionBottom = "一年学费"
    let numberOfStudentBottom = "学生数量"
    let overallRankingBottom = "综合排名"
    let applicationDeadlineBottom = "截止申请"
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = self.frame.width
        
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
        
        let fourLabelDistanceUnit = (width - (82+61+61+79))/5
        
        
        let oneYearTuitionTopLabel = UILabel(frame: CGRectMake(fourLabelDistanceUnit,290,82,40))
        oneYearTuitionTopLabel.text = oneYearTuitionTop
        oneYearTuitionTopLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionTopLabel.textColor = UIColor.blackColor()
        oneYearTuitionTopLabel.font = UIFont.systemFontOfSize(14)
        oneYearTuitionTopLabel.numberOfLines = 0
        
        let numberOfStudentTopLabel = UILabel(frame: CGRectMake(2*fourLabelDistanceUnit+82,290,61,40))
        numberOfStudentTopLabel.text = numberOfStudentTop
        numberOfStudentTopLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentTopLabel.textColor = UIColor.blackColor()
        numberOfStudentTopLabel.font = UIFont.systemFontOfSize(14)
        numberOfStudentTopLabel.numberOfLines = 0

        let overallRankingTopLabel = UILabel(frame: CGRectMake(3*fourLabelDistanceUnit+82+61,290,61,40))
        overallRankingTopLabel.text = overallRankingTop
        overallRankingTopLabel.textAlignment = NSTextAlignment.Center
        overallRankingTopLabel.textColor = UIColor.blackColor()
        overallRankingTopLabel.font = UIFont.systemFontOfSize(14)
        overallRankingTopLabel.numberOfLines = 0

        let applicationDeadlineTopLabel = UILabel(frame: CGRectMake(4*fourLabelDistanceUnit+82+61+61,290,79,40))
        applicationDeadlineTopLabel.text = applicationDeadlineTop
        applicationDeadlineTopLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineTopLabel.textColor = UIColor.blackColor()
        applicationDeadlineTopLabel.font = UIFont.systemFontOfSize(14)
        applicationDeadlineTopLabel.numberOfLines = 0

        let oneYearTuitionBottomLabel = UILabel(frame: CGRectMake(fourLabelDistanceUnit,330,82,18))
        oneYearTuitionBottomLabel.text = oneYearTuitionBottom
        oneYearTuitionBottomLabel.textAlignment = NSTextAlignment.Center
        oneYearTuitionBottomLabel.textColor = UIColor.blackColor()
        oneYearTuitionBottomLabel.font = UIFont.systemFontOfSize(11)
        oneYearTuitionBottomLabel.numberOfLines = 0
        
        let numberOfStudentBottomLabel = UILabel(frame: CGRectMake(2*fourLabelDistanceUnit+82,330,61,18))
        numberOfStudentBottomLabel.text = numberOfStudentBottom
        numberOfStudentBottomLabel.textAlignment = NSTextAlignment.Center
        numberOfStudentBottomLabel.textColor = UIColor.blackColor()
        numberOfStudentBottomLabel.font = UIFont.systemFontOfSize(11)
        numberOfStudentBottomLabel.numberOfLines = 0
        
        let overallRankingBottomLabel = UILabel(frame: CGRectMake(3*fourLabelDistanceUnit+82+61,330,61,18))
        overallRankingBottomLabel.text = overallRankingBottom
        overallRankingBottomLabel.textAlignment = NSTextAlignment.Center
        overallRankingBottomLabel.textColor = UIColor.blackColor()
        overallRankingBottomLabel.font = UIFont.systemFontOfSize(11)
        overallRankingBottomLabel.numberOfLines = 0
        
        let applicationDeadlineBottomLabel = UILabel(frame: CGRectMake(4*fourLabelDistanceUnit+82+61+61,330,79,18))
        applicationDeadlineBottomLabel.text = applicationDeadlineBottom
        applicationDeadlineBottomLabel.textAlignment = NSTextAlignment.Center
        applicationDeadlineBottomLabel.textColor = UIColor.blackColor()
        applicationDeadlineBottomLabel.font = UIFont.systemFontOfSize(11)
        applicationDeadlineBottomLabel.numberOfLines = 0

        let pieChartView = PieChartView()
        
        if DeviceType.IS_IPHONE_6 {
            pieChartView.frame = CGRectMake(width / 2 - 75,390,150,150)
            
        } else if DeviceType.IS_IPHONE_6P {
            pieChartView.frame = CGRectMake(width / 2 - 90,410,180,180)
        } else if DeviceType.IS_IPHONE_5 {
            pieChartView.frame = CGRectMake(width / 2 - 93.5,330,187,180)
        }
        
        
        pieChartView.legend.enabled = false
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeTransparent = true
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.transparentCircleRadiusPercent = 0.61
        pieChartView.descriptionText = ""
        pieChartView.centerText = "五大热门专业"
        pieChartView.setExtraOffsets(left: 0, top: 5, right: 0, bottom: 0)
        pieChartView.drawCenterTextEnabled = true
        
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = true
        
        


        self.setDataCount(pieChartView)
        
        
        pieChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: ChartEasingOption.EaseOutBack)
        
        self.addSubview(backgroundImageView)
        self.addSubview(avatarImageView)
        self.addSubview(universityChineseNameLabel)
        self.addSubview(universityEnglishNameLabel)
        self.addSubview(universityLocationLabel)
        self.addSubview(universityDescriptionLabel)
        self.addSubview(oneYearTuitionTopLabel)
        self.addSubview(numberOfStudentTopLabel)
        self.addSubview(overallRankingTopLabel)
        self.addSubview(applicationDeadlineTopLabel)
        self.addSubview(oneYearTuitionBottomLabel)
        self.addSubview(numberOfStudentBottomLabel)
        self.addSubview(overallRankingBottomLabel)
        self.addSubview(applicationDeadlineBottomLabel)
        self.addSubview(pieChartView)
        
    }
    
    
    func setDataCount(pieChartView:PieChartView){
        
        
        
        var yVals1 : [ChartDataEntry] = []
        var yVals2 : [ChartDataEntry] = []
        for index in 0...count {
            yVals1.append(ChartDataEntry(value: Double(arc4random_uniform(mult)+mult/2), xIndex: index))
            yVals2.append(ChartDataEntry(value: Double(arc4random_uniform(mult)+mult/2), xIndex: index))
            
        }
        
        var xVals : [String] = []
        for index in 0...count {
            xVals.append(self.parties[index % parties.count])
            
        }
        
        let dataSet: PieChartDataSet = PieChartDataSet(yVals: yVals1, label: "本校热门五大专业")
        dataSet.sliceSpace = 2.0
        
        //  add a lot of colors
        
        let colors :[UIColor] = [UIColor.yellowColor(),UIColor.blueColor(),UIColor.orangeColor(),UIColor.redColor(),UIColor.grayColor()]
        dataSet.colors = colors

        
        let data: PieChartData = PieChartData(xVals: xVals, dataSet: dataSet)
        let pFormatter: NSNumberFormatter = NSNumberFormatter()
        pFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(pFormatter)
        data.setValueFont(UIFont.systemFontOfSize(8))
        data.setValueTextColor(UIColor.blackColor())
        pieChartView.data = data
        pieChartView.highlightValues(nil)

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
}

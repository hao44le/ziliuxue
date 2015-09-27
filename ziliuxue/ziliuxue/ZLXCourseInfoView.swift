//
//  ZLXCourseInfoView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/26.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXCourseInfoView: UIView {

    var courseNameLabel:UILabel!
    var courseIntroLabel:UILabel!
    var registerButton:UIButton!
    
    
    
    init(frame: CGRect,dataModel:ZLXCourseDetailItem?) {
        super.init(frame: frame)
        
        let backgroundCardImage = UIImageView(frame:CGRectMake(0, 0, frame.size.width,  frame.size.height))
        backgroundCardImage.image = UIImage(named: "card_background")
        backgroundCardImage.userInteractionEnabled = true
        self.addSubview(backgroundCardImage)
        
        self.courseNameLabel = UILabel(frame: CGRectMake((ScreenSize.SCREEN_WIDTH - 200)/2, 20, 200, 30))
        self.courseNameLabel.text = "课程名字"
        self.courseNameLabel.font = UIFont.systemFontOfSize(30)
        self.courseNameLabel.textAlignment = NSTextAlignment.Center
        backgroundCardImage.addSubview(self.courseNameLabel)
        
        self.courseIntroLabel = UILabel(frame: CGRectMake(20, CGRectGetMaxY(self.courseNameLabel.frame) + 10, ScreenSize.SCREEN_WIDTH - 40, 40))
        self.courseIntroLabel.text = "这里是课程的基本介绍，长度未知"
        self.courseIntroLabel.numberOfLines = 0
        self.courseIntroLabel.textAlignment = NSTextAlignment.Center
        self.courseIntroLabel.font = UIFont.systemFontOfSize(18)
        backgroundCardImage.addSubview(self.courseIntroLabel)
        
        self.registerButton = UIButton(frame: CGRectMake((ScreenSize.SCREEN_WIDTH - 100)/2, CGRectGetMaxY(self.courseIntroLabel.frame) + 10, 100, 22))
        self.registerButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        //self.registerButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        self.registerButton.setBackgroundImage(UIImage(named: "writer_buy"), forState: UIControlState.Normal)
        self.registerButton.setTitle("注册课程", forState: UIControlState.Normal)
        backgroundCardImage.addSubview(self.registerButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

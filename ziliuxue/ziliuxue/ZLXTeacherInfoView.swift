//
//  ZLXTeacherInfoView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/19.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXTeacherInfoView: UIView {

    var avatarImage:UIImageView!
    var nameLabel:UILabel!
    var collectButton:UIButton!
    var collectNumLabel:UILabel!
    var likeNumLabel:UILabel!
    var finishedServiceNumLabel:UILabel!
    var teacherIntroLabel : UILabel!
    var buyServiceButton:UIButton!
    

    init(frame: CGRect,dataModel:ZLXTeacherInfoItem?) {
        super.init(frame: frame)
        
        let backgroundCardImage = UIImageView(frame:CGRectMake(0, 0, frame.size.width,  frame.size.height))
        backgroundCardImage.image = UIImage(named: "card_background")
        backgroundCardImage.userInteractionEnabled = true
        self.addSubview(backgroundCardImage)
        
        self.avatarImage = UIImageView(frame: CGRectMake(30, 20, 100, 100))
        self.avatarImage.image = UIImage(named: "little boy")
        backgroundCardImage.addSubview(self.avatarImage)
        
        self.nameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(self.avatarImage.frame) + 10, CGRectGetMinY(self.avatarImage.frame) + 10, 100, 30))
        self.nameLabel.text = "王瓜瓜"
        self.nameLabel.font = UIFont.systemFontOfSize(25)
        backgroundCardImage.addSubview(self.nameLabel)
        
        self.collectButton = UIButton(frame: CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 10, self.nameLabel.frame.origin.y, 60, 40))
        self.collectButton.setTitle("已收藏", forState: UIControlState.Normal)
        self.collectButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.collectButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        backgroundCardImage.addSubview(self.collectButton)
        
        let collectLabel = UILabel(frame: CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame) + 10, 45, 11))
        collectLabel.text = "收藏人数"
        collectLabel.font = UIFont.systemFontOfSize(10)
        backgroundCardImage.addSubview(collectLabel)
        
        let likeLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(collectLabel.frame) + 20, collectLabel.frame.origin.y, 45, 11))
        likeLabel.text = "喜欢人数"
        likeLabel.font = UIFont.systemFontOfSize(10)
        backgroundCardImage.addSubview(likeLabel)
        
        let finishedLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(likeLabel.frame) + 20, collectLabel.frame.origin.y, 60, 11))
        finishedLabel.text = "已完成服务"
        finishedLabel.font = UIFont.systemFontOfSize(10)
        backgroundCardImage.addSubview(finishedLabel)
        
        self.collectNumLabel = UILabel(frame: CGRectMake(collectLabel.frame.origin.x, CGRectGetMaxY(collectLabel.frame) + 5, 70, 25))
        self.collectNumLabel.text = "3104"
        self.collectNumLabel.font = UIFont.systemFontOfSize(18)
        self.collectNumLabel.textColor = UIColor.redColor()
        backgroundCardImage.addSubview(self.collectNumLabel)
        
        self.likeNumLabel = UILabel(frame: CGRectMake(likeLabel.frame.origin.x, CGRectGetMaxY(likeLabel.frame) + 5, 70, 25))
        self.likeNumLabel.text = "31700"
        self.likeNumLabel.font = UIFont.systemFontOfSize(18)
        self.likeNumLabel.textColor = UIColor.redColor()
        backgroundCardImage.addSubview(self.likeNumLabel)
        
        self.finishedServiceNumLabel = UILabel(frame: CGRectMake(finishedLabel.frame.origin.x, CGRectGetMaxY(finishedLabel.frame) + 5, 70, 25))
        self.finishedServiceNumLabel.text = "2020"
        self.finishedServiceNumLabel.font = UIFont.systemFontOfSize(18)
        self.finishedServiceNumLabel.textColor = UIColor.redColor()
        backgroundCardImage.addSubview(self.finishedServiceNumLabel)
        
        self.teacherIntroLabel = UILabel(frame: CGRectMake(20, CGRectGetMaxY(self.avatarImage.frame) + 8, frame.size.width - 40, 100))
        self.teacherIntroLabel.text = "本科学历，小学高级教师。小学语文优秀教师。1995年参加小学语文教学比武，荣获一等奖的第一名"
        self.teacherIntroLabel.numberOfLines = 0
        backgroundCardImage.addSubview(self.teacherIntroLabel)
        
        self.buyServiceButton = UIButton(frame: CGRectMake((frame.width - 100) / 2, frame.size.height - 45, 100, 30))
        self.buyServiceButton.setBackgroundImage(UIImage(named: "buyServiceButton"), forState: UIControlState.Normal)
        backgroundCardImage.addSubview(self.buyServiceButton)
        
        
        
        
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

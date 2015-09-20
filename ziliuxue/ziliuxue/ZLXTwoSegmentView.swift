//
//  ZLXTwoSegmentView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/19.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXTwoSegmentView: UIView {

    
    var title :UILabel!
    
    var firstSegmentTitle:UILabel!
    var secondSegmentTitle:UILabel!
    var firstSegmentContent:UILabel!
    var secondSegmentContent:UILabel!
    
    var commentLabel:UILabel!
    var dateLabel:UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backgroundCardImage = UIImageView(frame:CGRectMake(0, 0, frame.size.width,  frame.size.height))
        backgroundCardImage.image = UIImage(named: "card_background")
        backgroundCardImage.userInteractionEnabled = true
        self.addSubview(backgroundCardImage)
        
        self.title = UILabel(frame: CGRectMake((frame.size.width - 80) / 2, 20, 80, 30))
        self.title.textAlignment = NSTextAlignment.Center
        self.title.font = UIFont.systemFontOfSize(20)
        backgroundCardImage.addSubview(self.title)
        
        let upHorizontalLine = UIView(frame: CGRectMake(20, CGRectGetMaxY(self.title.frame) + 5, ScreenSize.SCREEN_WIDTH - 40, 1))
        upHorizontalLine.backgroundColor = UIColorFromHexRGB(0xf4dfbc)
        backgroundCardImage.addSubview(upHorizontalLine)
        
        let verticalLine = UIView(frame: CGRectMake(ScreenSize.SCREEN_WIDTH / 2, CGRectGetMaxY(upHorizontalLine.frame), 1, 140))
        verticalLine.backgroundColor = UIColorFromHexRGB(0xf4dfbc)
        backgroundCardImage.addSubview(verticalLine)
        
        self.firstSegmentTitle = UILabel(frame: CGRectMake(80, CGRectGetMaxY(upHorizontalLine.frame) + 10, 40, 20))
        self.firstSegmentTitle.text = "优点"
        self.firstSegmentTitle.font = UIFont.systemFontOfSize(18)
        self.firstSegmentTitle.textColor = UIColor.greenColor()
        backgroundCardImage.addSubview(self.firstSegmentTitle)
        
        self.secondSegmentTitle = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 120, CGRectGetMaxY(upHorizontalLine.frame) + 10, 40, 20))
        self.secondSegmentTitle.text = "缺点"
        self.secondSegmentTitle.font = UIFont.systemFontOfSize(18)
        self.secondSegmentTitle.textColor = UIColor.redColor()
        backgroundCardImage.addSubview(self.secondSegmentTitle)
        
        self.firstSegmentContent = UILabel(frame: CGRectMake(40, CGRectGetMaxY(self.firstSegmentTitle.frame) + 10, 120, 90))
        self.firstSegmentContent.text = "这里是经过总结以后老师的优点，长度最好不要超过四行字，这个需要服务器控制一下了，限定好四行规整好看"
        self.firstSegmentContent.numberOfLines = 0
        self.firstSegmentContent.font = UIFont.systemFontOfSize(13)
        backgroundCardImage.addSubview(self.firstSegmentContent)
        
        self.secondSegmentContent = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 160, CGRectGetMaxY(self.secondSegmentTitle.frame) + 10, 120, 90))
        self.secondSegmentContent.text = "这里是经过总结以后老师的缺点，长度最好不要超过四行字，这个需要服务器控制一下了，限定好四行规整好看"
        self.secondSegmentContent.numberOfLines = 0
        self.secondSegmentContent.font = UIFont.systemFontOfSize(13)
        backgroundCardImage.addSubview(self.secondSegmentContent)
        
        let downHorizontalLine = UIView(frame: CGRectMake(20, CGRectGetMaxY(self.secondSegmentContent.frame) + 10, ScreenSize.SCREEN_WIDTH - 40, 1))
        downHorizontalLine.backgroundColor = UIColorFromHexRGB(0xf4dfbc)
        backgroundCardImage.addSubview(downHorizontalLine)
        
        let latestCommentLabel = UILabel(frame: CGRectMake(20, CGRectGetMaxY(downHorizontalLine.frame) + 10, 150, 20))
        latestCommentLabel.text = "使用用户最新评价"
        latestCommentLabel.numberOfLines = 0
        latestCommentLabel.font = UIFont.systemFontOfSize(13)
        backgroundCardImage.addSubview(latestCommentLabel)
        
        self.dateLabel = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 110, CGRectGetMaxY(latestCommentLabel.frame) + 3, 80, 20))
        self.dateLabel.text = "2015年10月1日"
        self.dateLabel.font = UIFont.systemFontOfSize(11)
        backgroundCardImage.addSubview(self.dateLabel)
        
        self.commentLabel = UILabel(frame: CGRectMake(20, CGRectGetMaxY(self.dateLabel.frame) + 3, ScreenSize.SCREEN_WIDTH - 30, 20))
        self.commentLabel.text = "这里是用户感言，以后再确定是否要设定字数，这里是一行评价示例，这里是尾巴"
        self.commentLabel.font = UIFont.systemFontOfSize(11)
        backgroundCardImage.addSubview(self.commentLabel)
        
        
        
        
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

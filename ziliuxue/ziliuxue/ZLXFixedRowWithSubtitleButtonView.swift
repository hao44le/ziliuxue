//
//  ZLXFixedRowWithSubtitleButtonView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/26.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXFixedRowWithSubtitleButtonView: UIView {

    
    var title :UILabel!
    
    var button1 :UIButton!
    var button2 :UIButton!
    var button3 :UIButton!
    var button4 :UIButton!
    
    var label1:UILabel!
    var label2:UILabel!
    var label3:UILabel!
    var label4:UILabel!
    
    var labelDetail1:UILabel!
    var labelDetail2:UILabel!
    var labelDetail3:UILabel!
    var labelDetail4:UILabel!
    
    init(frame: CGRect,array:NSArray) {
        super.init(frame: frame)
        
        let backgroundCardImage = UIImageView(frame:CGRectMake(0, 0, frame.size.width,  frame.size.height))
        backgroundCardImage.image = UIImage(named: "card_background")
        backgroundCardImage.userInteractionEnabled = true
        self.addSubview(backgroundCardImage)
        
        self.title = UILabel(frame: CGRectMake((frame.size.width - 80) / 2, 20, 80, 30))
        self.title.textAlignment = NSTextAlignment.Center
        self.title.font = UIFont.systemFontOfSize(20)
        backgroundCardImage.addSubview(self.title)
        
        let count = array.count
        let rowHeight:CGFloat = 40
        
        var buttonArray = [self.button1,self.button2,self.button3,self.button4]
        var labelArray = [self.label1,self.label2,self.label3,self.label4]
        var detailLabelArray = [self.labelDetail1,self.labelDetail2,self.labelDetail3,self.labelDetail4]
        for(var i = 0; i < count;i++){
            
            let backgroundView = UIView(frame: CGRectMake(0, CGRectGetMaxY(self.title.frame) + 15 + CGFloat(i)*rowHeight, frame.size.width, rowHeight))
            if i%2 == 0{
                backgroundView.backgroundColor = UIColorFromHexRGB(0xF3F3F3)
            }
            backgroundCardImage.addSubview(backgroundView)
            
            
            labelArray[i] = UILabel(frame: CGRectMake(10, 5, 65, 30))
            labelArray[i].text = array[i] as? String
            labelArray[i].font = UIFont.systemFontOfSize(18)
            backgroundView.addSubview(labelArray[i])
            
            detailLabelArray[i] = UILabel(frame: CGRectMake(80, 5, 200, 30))
            detailLabelArray[i].text = "这是课程的一句简介，长度不超过这里"
            detailLabelArray[i].font = UIFont.systemFontOfSize(11)
            backgroundView.addSubview(detailLabelArray[i])
            
            buttonArray[i] = UIButton(frame: CGRectMake(frame.size.width - 80, 5, 70, 30))
            buttonArray[i].setTitle("详细信息", forState: UIControlState.Normal)
            buttonArray[i].titleLabel?.font = UIFont.systemFontOfSize(16)
            buttonArray[i].setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            backgroundView.addSubview(buttonArray[i])
            
        }
        
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

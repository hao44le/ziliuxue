//
//  ZLXTitleAndTagsView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/19.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXTitleAndTagsView: UIView {

    var title :UILabel!
    var button1 :UIButton!
    var button2 :UIButton!
    var button3 :UIButton!
    var button4 :UIButton!
    
    var label1:UILabel!
    var label2:UILabel!
    var label3:UILabel!
    var label4:UILabel!
    
    
    let labelArray = []
    

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
        let buttonWidth:CGFloat = 60
        let space:CGFloat = (ScreenSize.SCREEN_WIDTH - buttonWidth * CGFloat(count)) / CGFloat((count + 1))
    
        var buttonArray = [self.button1,self.button2,self.button3,self.button4]
        var labelArray = [self.label1,self.label2,self.label3,self.label4]
        for(var i = 0; i < count;i++){
            
            buttonArray[i] = UIButton(frame: CGRectMake(space * CGFloat((i + 1)) + CGFloat(i)*buttonWidth, CGRectGetMaxY(self.title.frame) + 10, buttonWidth, buttonWidth))
            buttonArray[i].layer.cornerRadius = buttonArray[i].bounds.size.width / 2
            buttonArray[i].layer.masksToBounds = true
            if ((array[0] as! NSArray)[0] as! NSString).isEqualToString("excel"){
                buttonArray[i].setBackgroundImage(UIImage(named: "badge"), forState: UIControlState.Normal)
            }else if ((array[0] as! NSArray)[0] as! NSString).isEqualToString("writer"){
                buttonArray[i].setBackgroundImage(UIImage(named: "dophin"), forState: UIControlState.Normal)
            }
    
            backgroundCardImage.addSubview(buttonArray[i])

            labelArray[i] = UILabel(frame: CGRectMake(buttonArray[i].frame.origin.x, CGRectGetMaxY(buttonArray[i].frame) + 5, buttonArray[i].frame.size.width, 20))
            labelArray[i].text = (array[i] as! NSArray)[1] as? String
            labelArray[i].textAlignment = NSTextAlignment.Center
            labelArray[i].font = UIFont.systemFontOfSize(10)
            backgroundCardImage.addSubview(labelArray[i])
            
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

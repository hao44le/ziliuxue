//
//  ZLXCourseFilterView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/26.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class ZLXCourseFilterView: UIView,JSDropDownMenuDataSource,JSDropDownMenuDelegate {

    var menu:JSDropDownMenu!
    
    var label1:UILabel!
    var label2:UILabel!
    var label3:UILabel!
    var label4:UILabel!
    var label5:UILabel!
    var label6:UILabel!
    
    var labelDetail1:UILabel!
    var labelDetail2:UILabel!
    var labelDetail3:UILabel!
    var labelDetail4:UILabel!
    var labelDetail5:UILabel!
    var labelDetail6:UILabel!
    
    var location = ["北京","上海","南京","杭州"]
    var time = ["上午","下午","晚上"]
    var price = ["<1000","1000-2000","2000-3000",">3000"]
    
    var locationIndex = 0
    var timeIndex = 0
    var priceIndex = 0
    
    var courseSepc = ["课程名称","课程时间","开课地点","课程价格","剩余座位","教课老师"]
    
    init(frame: CGRect,array:NSArray) {
        super.init(frame: frame)
        
        let backgroundCardImage = UIImageView(frame:CGRectMake(0, 0, frame.size.width,  frame.size.height))
        backgroundCardImage.image = UIImage(named: "card_background")
        backgroundCardImage.userInteractionEnabled = true
        self.addSubview(backgroundCardImage)
        
        self.menu = JSDropDownMenu(origin: CGPointMake(0, 0), andHeight: 40)
        self.menu.indicatorColor = UIColorFromHexRGB(0xafafaf)
        self.menu.separatorColor = UIColorFromHexRGB(0xd2d2d2)
        self.menu.textColor = UIColorFromHexRGB(0x535353)
        self.menu.delegate = self
        self.menu.dataSource = self
        self.addSubview(self.menu)
        
        let count = array.count
        let rowHeight:CGFloat = 40
        
        var labelArray = [self.label1,self.label2,self.label3,self.label4,self.label5,self.label6]
        for(var i = 0; i < count;i++){
            
            let backgroundView = UIView(frame: CGRectMake(0, CGRectGetMaxY(self.menu.frame) + 15 + CGFloat(i)*rowHeight, frame.size.width, rowHeight))
            if i%2 == 0{
                backgroundView.backgroundColor = UIColorFromHexRGB(0xF3F3F3)
            }
            backgroundCardImage.addSubview(backgroundView)
            
            
            labelArray[i] = UILabel(frame: CGRectMake(25, 5, 230, 30))
            labelArray[i].text = array[i] as? String
            labelArray[i].font = UIFont.systemFontOfSize(15)
            labelArray[i].text = self.courseSepc[i]
            backgroundView.addSubview(labelArray[i])
            
//            buttonArray[i] = UIButton(frame: CGRectMake(frame.size.width - 80, 5, 70, 30))
//            buttonArray[i].setTitle("点击试阅", forState: UIControlState.Normal)
//            buttonArray[i].titleLabel?.font = UIFont.systemFontOfSize(16)
//            buttonArray[i].setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//            backgroundView.addSubview(buttonArray[i])
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int {
        return 3
    }
    
    func haveRightTableViewInColumn(column: Int) -> Bool {
        return false
    }
    
    func widthRatioOfLeftColumn(column: Int) -> CGFloat {
        return 1
    }
    
    func currentLeftSelectedRow(column: Int) -> Int {
        switch column{
        case 0 :
            return self.locationIndex
        case 1:
            return self.timeIndex
        case 2:
            return self.priceIndex
        default:
            return 0
        }
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        switch column{
        case 0 :
            return self.location.count
        case 1:
            return self.time.count
        case 2:
            return self.price.count
        default:
            return 0
        }
        
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        switch column{
        case 0 :
            return self.location[self.locationIndex]
        case 1:
            return self.time[self.timeIndex]
        case 2:
            return self.price[self.priceIndex]
        default:
            return ""
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        switch indexPath.column{
        case 0 :
            return self.location[indexPath.row]
        case 1:
            return self.time[indexPath.row]
        case 2:
            return self.price[indexPath.row]
        default:
            return ""
        }
    }
    
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        switch indexPath.column{
        case 0 :
            self.locationIndex = indexPath.row
        case 1:
            self.timeIndex = indexPath.row
        case 2:
            self.priceIndex = indexPath.row
        default:
            return
        }
    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  SchoolRankFilterView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/28.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankFilterCellView: UIView {
    
    var button:UIButton?
    var indicatorImage:UIImageView?
    var lowerLine:UIView?
    
    init(frame: CGRect,buttonTitle:String?,indicatorImageName:String?){
        super.init(frame: frame)
        
        let upperLine = UIView(frame: CGRectMake(0,0,frame.width,1))
        upperLine.backgroundColor = UIColor.whiteColor()
        self.addSubview(upperLine)
        
        self.lowerLine = UIView(frame: CGRectMake(0,frame.height - 1,frame.width,1))
        self.lowerLine!.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.lowerLine!)
        
        if (buttonTitle != nil){
            self.button = UIButton(frame: CGRectMake(0, (frame.height - 35)/2, frame.width, 35))
            self.button!.setTitle(buttonTitle, forState: UIControlState.Normal)
            self.button!.titleLabel?.textAlignment = NSTextAlignment.Center
            self.button!.titleLabel?.textColor = UIColor.whiteColor()
            self.button!.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
            self.addSubview(self.button!)
        }
        
        if (indicatorImageName != nil){
            self.indicatorImage = UIImageView(frame: CGRectMake(frame.width - 35, (frame.height - 20)/2, 20, 20))
            self.indicatorImage?.image = UIImage(named: indicatorImageName!)
            self.addSubview(self.indicatorImage!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SchoolRankFilterView: UIView,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    var collegeCell:SchoolRankFilterCellView!
    var undergraduateCell:SchoolRankFilterCellView!
    var postgraduateCell:SchoolRankFilterCellView!
    var tableView:UITableView!
    
    var tableViewData = ["航空与航空工程专业","生物与农业专业","软件工程","计算机科学与工程","电子电气与通讯工程","经济管理专业","仪器科学工程","刑法专业","抓人专业","考古文学","应用数学专业","艺术专业","人文社科专业","信息科学工程","当科学家专业","滥用毒品和酒精研究生专业","你编不下去了","那我也遍不下去了专业","谁爱编谁来编吧","反正我是不编了专业"]
    
    var data = sortedStringByPinYinFirstChar(["航空与航空工程专业","生物与农业专业","软件工程","计算机科学与工程","电子电气与通讯工程","经济管理专业","仪器科学工程","刑法专业","抓人专业","考古文学","应用数学专业","艺术专业","人文社科专业","信息科学工程","当科学家专业","滥用毒品和酒精研究生专业","你编不下去了","那我也遍不下去了专业","谁爱编谁来编吧","反正我是不编了专业"])

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = self.bounds
        self.addSubview(effectView)
        //self.backgroundColor = UIColorFromRGBA(0, g: 0, b: 0, a: 0.7)
        
        self.collegeCell = SchoolRankFilterCellView(frame: CGRectMake(0, 20, frame.width, 40), buttonTitle: "文理学院综合排名", indicatorImageName: nil)
        self.addSubview(self.collegeCell)
        
        self.undergraduateCell = SchoolRankFilterCellView(frame: CGRectMake(0, CGRectGetMaxY(self.collegeCell.frame) + 10, frame.width, 40), buttonTitle: "本科生综合排名", indicatorImageName: nil)
        self.addSubview(self.undergraduateCell)
        
        self.postgraduateCell = SchoolRankFilterCellView(frame: CGRectMake(0, CGRectGetMaxY(self.undergraduateCell.frame) + 10, frame.width, 40), buttonTitle: "研究生专业排名", indicatorImageName: "expandableImage")
        self.addSubview(self.postgraduateCell)
        
        self.postgraduateCell.button?.addTarget(self, action: Selector("postgraduateButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func postgraduateButtonClicked(){
        
         let leftHeightToButtom = ScreenSize.SCREEN_HEIGHT - CGRectGetMaxY(self.postgraduateCell.frame)
        
        if nil == self.tableView{
            self.tableView = UITableView(frame: CGRectMake(0,CGRectGetMaxY(self.postgraduateCell.frame) + 5,self.frame.width,leftHeightToButtom - 100))
            self.tableView.backgroundColor = UIColor(white: 1, alpha: 0)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .None
            self.tableView.bounces = false
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
            self.tableView.sectionIndexColor = UIColor.whiteColor()
            self.tableView.sectionIndexBackgroundColor = UIColor(white: 1, alpha: 0)
  
        }
        
       
        if nil == self.tableView.superview{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.postgraduateCell.lowerLine?.frame = CGRectOffset(self.postgraduateCell.lowerLine!.frame, 0, self.tableView.frame.height + 10)
                
                }) { (completion) -> Void in
                    self.addSubview(self.tableView)
            }
        }

        
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("rankCell") as?SchoolRankFilterCell
        
   
        if nil == cell{
            cell = SchoolRankFilterCell(style: UITableViewCellStyle.Default, reuseIdentifier: "rankCell")

        }
        
        cell?.label?.text = self.data[indexPath.row] as? String
        
        return cell!
    }
    

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let upperIndex = scrollView.contentOffset.y / 44
        let lowerIndex = (scrollView.contentOffset.y + self.tableView.frame.height) / 44 - 1
        let totalIndex = scrollView.contentSize.height / 44
        
        for i in 0..<Int(totalIndex){
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:i , inSection: 0)) as? SchoolRankFilterCell
            cell?.label.textColor = UIColor(white: 1, alpha:1)
    
        }
        
        let upperCell1 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:Int(upperIndex) , inSection: 0)) as? SchoolRankFilterCell
        let upperCell2 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:Int(upperIndex) + 1, inSection: 0)) as? SchoolRankFilterCell
        let lowerCell1 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:Int(lowerIndex) , inSection: 0)) as? SchoolRankFilterCell
        let lowerCell2 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow:Int(lowerIndex) + 1 , inSection: 0)) as? SchoolRankFilterCell
     
            upperCell1?.label.textColor = UIColor(white: 1, alpha: 0.3)
            upperCell2?.label.textColor = UIColor(white: 1, alpha: 0.7)
            lowerCell1?.label.textColor = UIColor(white: 1, alpha: 0.7)
            lowerCell2?.label.textColor = UIColor(white: 1, alpha: 0.3)

    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["A","B","C","D","E","F","G","H","I"]
    }
    
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        
//    }
    
    
    
    
    

}

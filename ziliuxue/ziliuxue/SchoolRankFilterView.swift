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
    var effectView:UIVisualEffectView?
    
    init(frame: CGRect,buttonTitle:String?,indicatorImageName:String?){
        super.init(frame: frame)
        
        let upperLine = UIView(frame: CGRectMake(0,0,frame.width,1))
        upperLine.backgroundColor = UIColor(white: 0.7, alpha: 1)
        self.addSubview(upperLine)
        
        self.lowerLine = UIView(frame: CGRectMake(0,frame.height - 1,frame.width,1))
        self.lowerLine!.backgroundColor = UIColor(white: 0.7, alpha: 1)
        self.addSubview(self.lowerLine!)
        
//        let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        self.effectView = UIVisualEffectView(effect: blur)
//        self.effectView!.frame = CGRectMake(0, 1, self.frame.width, self.frame.height - 2)
//        self.addSubview(self.effectView!)
        self.backgroundColor = UIColor(white: 0.7, alpha: 0.1)
        
        if (buttonTitle != nil){
            self.button = UIButton(frame: CGRectMake(0, (frame.height - 35)/2, frame.width, 35))
            self.button!.setTitle(buttonTitle, forState: UIControlState.Normal)
            self.button!.titleLabel?.textAlignment = NSTextAlignment.Center
            self.button!.titleLabel?.textColor = UIColor.whiteColor()
            self.button!.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
            self.addSubview(self.button!)
        
        }
        
        if (indicatorImageName != nil){
            self.indicatorImage = UIImageView(frame: CGRectMake(frame.width - 35, (frame.height - 6)/2, 11, 6))
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
    
    var data = ["航空与航空工程专业","生物与农业专业","软件工程","计算机科学与工程","电子电气与通讯工程","经济管理专业","仪器科学工程","刑法专业","抓人专业","考古文学","应用数学专业","艺术专业","人文社科专业","信息科学工程","当科学家专业","滥用毒品和酒精研究生专业","你编不下去了","那我也遍不下去了专业","谁爱编谁来编吧","反正我是不编了专业"]
    
    var tableViewData:NSArray!
    var indexData:[String]!

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
        
        self.postgraduateCell = SchoolRankFilterCellView(frame: CGRectMake(0, CGRectGetMaxY(self.undergraduateCell.frame) + 10, frame.width, 40), buttonTitle: "研究生专业排名", indicatorImageName: "filter_gradMajor_arrow")
        self.addSubview(self.postgraduateCell)
        
        self.postgraduateCell.button?.addTarget(self, action: Selector("postgraduateButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.tableViewData = sortedStringByPinYinFirstChar(self.data)
        self.indexData = sortedPinYinFirstCharByPinYinFirstChar(self.data) as! [String]
        
        
        
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
                let effectViewFrame = self.postgraduateCell.frame
                self.postgraduateCell.frame = CGRectMake(effectViewFrame.origin.x,effectViewFrame.origin.y,effectViewFrame.width,effectViewFrame.height + self.tableView.frame.height + 10)
                self.postgraduateCell.indicatorImage?.transform = CGAffineTransformMakeScale(1, -1)
                
                }) { (completion:Bool) -> Void in
                    self.addSubview(self.tableView)
            }
        }else{
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                
                self.tableView.removeFromSuperview()
                
                let effectViewFrame = self.postgraduateCell.frame
                self.postgraduateCell.frame = CGRectMake(effectViewFrame.origin.x,effectViewFrame.origin.y,effectViewFrame.width,effectViewFrame.height - self.tableView.frame.height - 10)
                self.postgraduateCell.lowerLine?.frame = CGRectOffset(self.postgraduateCell.lowerLine!.frame, 0, -(self.tableView.frame.height + 10))
                self.postgraduateCell.indicatorImage?.transform = CGAffineTransformMakeScale(1, 1)
                
                }, completion: { (completion:Bool) -> Void in
                    
            })
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
        
        cell?.label?.text = self.tableViewData[indexPath.row] as? String
        
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
        
        return self.indexData
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        print(title)
//        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 5, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
        return 1
        
    }
    
    
    
    
    

}

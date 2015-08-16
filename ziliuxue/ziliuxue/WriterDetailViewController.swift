//
//  WriterDetailViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/2/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class WriterDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var backScrollView: UIScrollView!
    
    
    @IBOutlet var tableView: UITableView!
    
    var id:String?
    
    var detailDataDic:ServiceWriterDetail?
    
    
    @IBOutlet var avatar: UIImageView!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var completed_casesLabel: UILabel!
    
    @IBOutlet var years_in_serviceLabel: UILabel!
    
    @IBOutlet var favLabel: UILabel!
    
    
    

    var selfIntro = [["化学类","本科","￥1999"],["化工","研究生","￥1799"],["信息","本科","￥2099"],["计算机","研究生","￥3999"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.id = "55c949b958ef03209890b4c6"
        
        if nil != self.id{
            
            ServerMethods.getWriterDetail(self.id)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didGetWriterDetail:"), name: "didGetWriterDetail", object: nil)
        }
        
        self.backScrollView.frame = CGRectMake(0, 64, ScreenSize.SCREEN_WIDTH, CGRectGetMaxY(self.tableView.frame) - 200)
        
        self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1000)
        
//        println(self.tableView.frame)
//        println(self.backScrollView.contentSize)
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didGetWriterDetail(notification:NSNotification)
    {
        self.detailDataDic = notification.object as? ServiceWriterDetail
        Tool.showSuccessHUD("获取成功")
        
        var avatarURL = NSURL(string: ServerConstant.baseURL + self.detailDataDic!.avatar_url)
        self.avatar.sd_setImageWithURL(avatarURL, placeholderImage: nil)
        
        self.name.text = self.detailDataDic?.name
        self.titleLabel.text = self.detailDataDic?.title
        
        
        self.tableView.reloadData()
        
        
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if nil != self.detailDataDic{
            return 4
        }
        else{
            return 0
        }
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
        case 0:
            var commentHeaderView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            commentHeaderView.backgroundColor = UIColor(red: 220/255, green: 244/255, blue: 244/255, alpha: 1)
            var starView = UIImageView(frame: CGRectMake(5, 0, 80, 20))
            starView.image = UIImage(named: "ratingStar")
            commentHeaderView.addSubview(starView)
            
            return commentHeaderView
        case 1:
            var sampleView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            sampleView.backgroundColor = UIColor(red: 220/255, green: 244/255, blue: 244/255, alpha: 1)
            var leftLabel = UILabel(frame: CGRectMake(5, 0, 150, 20))
            leftLabel.text = "部分写作样本"
            leftLabel.font = UIFont(name: "Helvetica", size: 13)
            sampleView.addSubview(leftLabel)
            
            var rightLabel = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 60, 0, 60, 20))
            rightLabel.text = "免费"
            rightLabel.font = UIFont(name: "Helvetica", size: 13)
            sampleView.addSubview(rightLabel)
            
            return sampleView
        case 2:
            var resumeView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            resumeView.backgroundColor = UIColor(red: 220/255, green: 244/255, blue: 244/255, alpha: 1)
            var leftLabel = UILabel(frame: CGRectMake(5, 0, 150, 20))
            leftLabel.text = "写作服务：个人简历"
            leftLabel.font = UIFont(name: "Helvetica", size: 13)
            resumeView.addSubview(leftLabel)
            
            var rightLabel = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 60, 0, 60, 20))
            rightLabel.text = "￥799元"
            rightLabel.font = UIFont(name: "Helvetica", size: 13)
            resumeView.addSubview(rightLabel)
            
            return resumeView
            
        case 3:
            var selfIntroView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            selfIntroView.backgroundColor = UIColor(red: 220/255, green: 244/255, blue: 244/255, alpha: 1)
            var leftLabel = UILabel(frame: CGRectMake(5, 0, 150, 20))
            leftLabel.text = "写作服务：个人声明"
            leftLabel.font = UIFont(name: "Helvetica", size: 13)
            selfIntroView.addSubview(leftLabel)

            return selfIntroView
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return self.detailDataDic!.comments.count
        case 1:
            return self.detailDataDic!.samples.count
        case 2:
            return 4
        case 3:
            return self.selfIntro.count
        default:
            return 0
        }
    

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cellIdentifier = "WriterDetailComments"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            }
            
            cell?.textLabel?.text = self.detailDataDic!.comments[indexPath.row] as? String
            cell?.textLabel?.font = UIFont(name: "Helvetica", size: 13)
            
            if indexPath.row == (self.detailDataDic!.comments.count - 1){
                cell?.textLabel?.text = "查看全部231条评价"
                cell?.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
                cell?.textLabel?.font = UIFont(name: "Helvetica", size: 14)
                cell?.textLabel?.textColor = UIColor.blueColor()
            }
            
            
            return cell!
        }
        else
        {
            
            let cellIdentifier = "WriterDetailCommon"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? WriterDetailTableViewCell
    
            if (cell == nil) {
                cell = WriterDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        
            }
            
            var row = indexPath.row
            switch indexPath.section{
            case 1:
                cell?.itemLabel.text = self.detailDataDic!.samples[row]["area"] as? String
                cell?.detailLabel.text = self.detailDataDic!.samples[row]["description"] as? String
            case 2:
                switch row{
                case 0:
                    cell?.itemLabel.text = "内容"
                    cell?.detailLabel.text = self.detailDataDic?.services[0]["description"] as? String
                case 1:
                    cell?.itemLabel.text = "类别"
                    cell?.detailLabel.text = self.detailDataDic?.services[0]["targets"] as? String
                case 2:
                    cell?.itemLabel.text = "格式"
                    cell?.detailLabel.text = self.detailDataDic?.services[0]["format"] as? String
                case 3:
                    cell?.itemLabel.text = "时间"
                    cell?.detailLabel.text = self.detailDataDic?.services[0]["time"] as? String
                default:
                    
                    break
                }
            case 3:
                cell?.itemLabel.text = self.selfIntro[0][0]
                cell?.detailLabel.text = self.selfIntro[0][1]
                cell?.priceLabel.text = self.selfIntro[row][2]
            
                cell?.button.setBackgroundImage(UIImage(named: "buyButton"), forState: UIControlState.Normal)
            default:
                break
                
            }

            return cell!
        }
        
   
     
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

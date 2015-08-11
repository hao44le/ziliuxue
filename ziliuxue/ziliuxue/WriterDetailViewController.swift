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
    
    var comments = ["超强写作老师。条理超清晰，循序渐进，提高很快","超强的写作老师，我的OFFER可以100%归功于Ken Wang. ","太牛，太值了。超强，超快，超幽默！"]
    var sample = [["化学","针对化学理论专业"],["化工","针对化工材料专业"],["信息","针对化学化工类信息工程"],["计算机","针对计算机应用和人工智能"]]
    var resume = ["content":"包括2次电话会谈和2次修改","category":"本科，硕士研究生，或工业界找工作","format":"Word, PDF 或其他通用格式","time":"2 周"]
    var selfIntro = [["化学类","本科","￥1999"],["化工","研究生","￥1799"],["信息","本科","￥2099"],["计算机","研究生","￥3999"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1500)
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
        case 0:
            var commentHeaderView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            commentHeaderView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            var starView = UIImageView(frame: CGRectMake(5, 0, 80, 20))
            starView.image = UIImage(named: "ratingStar")
            commentHeaderView.addSubview(starView)
            
            return commentHeaderView
        case 1:
            var sampleView = UIView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 25))
            sampleView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
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
            resumeView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
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
            selfIntroView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
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
            return self.comments.count
        case 1:
            return self.sample.count
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
            
            cell?.textLabel?.text = self.comments[indexPath.row] 
            cell?.textLabel?.font = UIFont(name: "Helvetica", size: 13)
            
            return cell!
        }
        else
        {
            let cellIdentifier = "WriterDetailCommon"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? WriterDetailTableViewCell
    
            if (cell == nil) {
                cell = WriterDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        
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

//
//  WriterDetailViewController.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/2/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class WriterDetailViewController: UIViewController{

    
    @IBOutlet var backScrollView: UIScrollView!
    
    var teacherInfoView:ZLXTeacherInfoView!
    var excellentField:ZLXTitleAndTagsView!
    var probationView:ZLXFixedRowsWithTitleView!
    var similarWriter:ZLXTitleAndTagsView!
    var evaluationAndCommentView:ZLXTwoSegmentView!
    
    var id:String?
    
    var detailDataDic:ServiceWriterDetail?

    var selfIntro = [["化学类","本科","￥1999"],["化工","研究生","￥1799"],["信息","本科","￥2099"],["计算机","研究生","￥3999"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.id = "55c949b958ef03209890b4c6"
//        
//        if nil != self.id{
//            
//            ServerMethods.getWriterDetail(self.id)
//            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didGetWriterDetail:"), name: "didGetWriterDetail", object: nil)
//        }
 
        self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1150)
        self.setupShareButton()
        self.backScrollView.backgroundColor = UIColorFromHexRGB(0xf0f4f7)
        self.teacherInfoView = ZLXTeacherInfoView(frame: CGRectMake(5, 69, ScreenSize.SCREEN_WIDTH - 10, 280), dataModel: nil)
        self.backScrollView.addSubview(self.teacherInfoView)
        
        self.excellentField = ZLXTitleAndTagsView(frame: CGRectMake(5, CGRectGetMaxY(self.teacherInfoView.frame), ScreenSize.SCREEN_WIDTH - 10, 150), array: [["excel","简历"],["excel","个人陈述"],["excel","推荐信"]])
        self.excellentField.title.text = "擅长领域"
        self.backScrollView.addSubview(self.excellentField)
        
        self.probationView = ZLXFixedRowsWithTitleView(frame: CGRectMake(5, CGRectGetMaxY(self.excellentField.frame) , ScreenSize.SCREEN_WIDTH - 10, 190), array: ["个人简历-Cleiden University","申请信-Monster University","推荐信-Hogwarts University"])
        self.probationView.title.text = "作品试读"
        self.backScrollView.addSubview(self.probationView)
        
        self.similarWriter = ZLXTitleAndTagsView(frame: CGRectMake(5, CGRectGetMaxY(self.probationView.frame) , ScreenSize.SCREEN_WIDTH - 10, 150), array: [["writer","小汪"],["writer","小猫"],["writer","小蜥蜴"],["writer","小老虎"]])
        self.similarWriter.title.text = "相似写手"
        self.backScrollView.addSubview(self.similarWriter)
        
        self.evaluationAndCommentView = ZLXTwoSegmentView(frame: CGRectMake(5, CGRectGetMaxY(self.similarWriter.frame) , ScreenSize.SCREEN_WIDTH - 10, 300))
        self.evaluationAndCommentView.title.text = "综合评价"
        self.backScrollView.addSubview(self.evaluationAndCommentView)
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupShareButton(){
        let shareButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        shareButton.backgroundColor = UIColor.clearColor()
        shareButton.setImage(UIImage(named: "share_button_normal"), forState: UIControlState.Normal)
        shareButton.setImage(UIImage(named: "share_button_highlighted"), forState: UIControlState.Highlighted)
        //shareButton.addTarget(self, action: Selector(""), forControlEvents: UIControlEvents.TouchUpInside)
        let shareItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem = shareItem
    }
    
    func didGetWriterDetail(notification:NSNotification)
    {
        self.detailDataDic = notification.object as? ServiceWriterDetail
        Tool.showSuccessHUD("获取成功")
        
        //let avatarURL = NSURL(string: ServerConstant.baseURL + self.detailDataDic!.avatar_url)

    }
    
    func createTeacherInfoView(){
        
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

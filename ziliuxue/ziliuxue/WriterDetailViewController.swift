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
 
        //self.backScrollView.contentSize = CGSizeMake(ScreenSize.SCREEN_WIDTH, 1000)

  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

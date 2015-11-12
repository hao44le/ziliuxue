//
//  LoginPopView.swift
//  ziliuxue
//
//  Created by WangShuo on 15/11/12.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

@objc protocol WeChatLoginDelegate{
    
    func weChatLoginDidSucceed()
    func weChatLoginDidFail()
}

class LoginPopView: UIView {
    
    weak var delegate:WeChatLoginDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setUpBlurView()
        self.setUpLeaveButton()
        self.setUpIntroLabel()
        self.setUpWeChatButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpBlurView(){
        
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = self.bounds
        self.addSubview(effectView)
    }
    
    func setUpLeaveButton(){
        
        let leaveButton = UIButton(frame: CGRectMake((self.frame.width - 20)/2 , 50,20,20))
        leaveButton.setBackgroundImage(UIImage(named: "leave_icon"), forState: UIControlState.Normal)
        leaveButton.addTarget(self, action: Selector("dismissLoginView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(leaveButton)
    }
    
    func setUpIntroLabel(){
        
        let introLabel = UILabel(frame: CGRectMake(0 , 190,ScreenSize.SCREEN_WIDTH,30))
        introLabel.text = "请微信登录以进行更多操作"
        introLabel.textColor = UIColor.whiteColor()
        introLabel.textAlignment = NSTextAlignment.Center
        introLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(introLabel)
    }
    
    func setUpWeChatButton(){
        let weChatButton = UIButton(frame: CGRectMake((self.frame.width - 50)/2 , 250,50,50))
        weChatButton.setBackgroundImage(UIImage(named: "weixin"), forState: UIControlState.Normal)
        weChatButton.addTarget(self, action: Selector("weChatLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(weChatButton)
    }
    
    func dismissLoginView(){
        self.removeFromSuperview()
    }
    
    func weChatLogin(){
        //这里写打开微信等登录方法
        //登录结果返回以后写回掉delegate方法
        
        //成功后
        self.delegate.weChatLoginDidSucceed()
        //失败后
        self.delegate.weChatLoginDidFail()
    }

}

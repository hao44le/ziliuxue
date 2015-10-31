//
//  AppDelegate.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit
import MediaPlayer




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {
//,WeiboSDKDelegate
    var window: UIWindow?
    var drawerController:MMDrawerController!
    var isFullScreen = false
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
//        let types: UIUserNotificationType = [UIUserNotificationType.Badge, UIUserNotificationType.Alert, UIUserNotificationType.Sound]
//        
//        let settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
//        
//        application.registerUserNotificationSettings( settings )
//        application.registerForRemoteNotifications()
        
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterFullScreen", name:MPMoviePlayerWillEnterFullscreenNotification , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willExitFullScreen", name:MPMoviePlayerWillExitFullscreenNotification, object: nil)
        
        //textField和键盘自适应高度的开关
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().overrideKeyboardAppearance = true
        IQKeyboardManager.sharedManager().keyboardAppearance = UIKeyboardAppearance.Dark
        
        //weibo初始化
//        WeiboSDK.enableDebugMode(true)
//        WeiboSDK.registerApp(kWeiboAppKey)
        
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        WXApi.registerApp("wx6d67e31185e79352")
        
        
        Logging.setUpLogger()
        NSTimer.scheduledTimerWithTimeInterval(60*10, target: Logging(), selector: "uploadRemaninggzFile", userInfo: nil, repeats: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "compressionDidSucceed:", name: "compressionDidSucceed", object: nil)
        
        
        let kMaximumLeftDrawerWidth:CGFloat = 200.0
        let leftSideDrawerViewController:LeftDrawerTableViewController = LeftDrawerTableViewController(nibName: "LeftDrawerTableViewController", bundle: nil)
        
        let centerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SchoolRankViewController") as! SchoolRankViewController
        
        
        let navigationController = UINavigationController(rootViewController: centerViewController)
        navigationController.navigationBar.shadowImage = UIImage()
        
        navigationController.navigationBar.barTintColor = Utils.mainColor
        navigationController.navigationBar.tintColor = UIColor.whiteColor()
        navigationController.navigationBar.barStyle = UIBarStyle.Black
        //navigationController.navigationBar.tintColor = UIColor.whiteColor()
        //navigationController.navigationBar.barStyle = UIBarStyle.Black
        
        drawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideDrawerViewController)
        
        drawerController.setMaximumLeftDrawerWidth(kMaximumLeftDrawerWidth, animated:false, completion: nil)
        
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningNavigationBar
        
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        self.window?.rootViewController = self.drawerController
   
        
        // Override point for customization after application launch.
        return true
    }
    func willEnterFullScreen(){
        isFullScreen = true
    }
    func willExitFullScreen(){
        isFullScreen = false
    }
    func compressionDidSucceed(noti:NSNotification){
        //print("compressionDidSucceed Method")
        
        let userInfo : NSDictionary = noti.userInfo!
        let path = userInfo.objectForKey("filePath") as! String
        LocalFileManager.uploadFileAtPath(path)
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for var i = 0; i < deviceToken.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //println("tokenString: \(tokenString)")
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if isFullScreen {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.Portrait
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //Apple 已经弃用这个方法 只留用下面的方法即可
//    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
//        
//        var urlString = url.absoluteString
//        if urlString!.hasPrefix(""){
//            
//        }else if urlString!.hasPrefix(""){
//            
//        }
//        return WXApi.handleOpenURL(url, delegate: self)
//    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        print(sourceApplication)
        if sourceApplication == "com.tencent.xin" {
            return WXApi.handleOpenURL(url, delegate: self)
            
        }else if sourceApplication == "com.sina.weibo"{
            
            //return WeiboSDK.handleOpenURL(url, delegate: self)
        }else {
            var navi:UINavigationController?
            let vc:UIViewController?
            if url.scheme == "zlx" {
//                if url.host == "login" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
//                } else if url.host == "signup" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
//                } else if url.host == "secondTab" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("secondTab") as! SecondTabViewController
//                }  else if url.host == "thirdTab" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdTab") as! ThirdTabViewController
//                } else if url.host == "fourthTab" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("fourthTab") as! FourthTabBarViewController
//                }  else if url.host == "personalInfo" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalInfoTab") as! PersonalInfoViewController
//                } else if url.host == "timeline" {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
//                    let tab = vc as! CenterTabViewController
//                    tab.selectedIndex = 1
//                } else if url.host == nil {
//                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
//                }
               // navi = UINavigationController(rootViewController: vc!)
                navi!.navigationBar.barTintColor = Utils.mainColor
                navi!.navigationBar.tintColor = UIColor.whiteColor()
                navi!.navigationBar.barStyle = UIBarStyle.Black
                
                self.drawerController.setCenterViewController(navi, withCloseAnimation: true, completion: nil)
            }
            
        }
        return false
    }
    
    
//    func didReceiveWeiboRequest(request: WBBaseRequest!) {
//        
//        print("request============")
//        print(request.userInfo)
//    }
//    
//    func didReceiveWeiboResponse(response: WBBaseResponse!) {
//        
//        if response.isKindOfClass(WBAuthorizeResponse){
//
//            if response.statusCode.rawValue == 0{
//                Tool.showSuccessHUD("授权成功")
//                self.queryWeiboUserData((response as! WBAuthorizeResponse).userID, accessToken: (response as! WBAuthorizeResponse).accessToken)
//            }else{
//                Tool.showErrorHUD("授权失败")
//            }
//   
////            println("response============userID")
////            println((response as! WBAuthorizeResponse).userID)
////            println("response============accessToken")
////            println((response as! WBAuthorizeResponse).accessToken)
////            println("response============userInfo")
////            println(response.userInfo)
////
////            println(response.requestUserInfo)
//        }else if response.isKindOfClass(WBSendMessageToWeiboResponse){
//            
//        }else if response.isKindOfClass(WBPaymentResponse){
//            
//        }
//
//    }
    
    func queryWeiboUserData(userID:NSString,accessToken:NSString){
        
        let weiboURL = "https://api.weibo.com/2/users/show.json"
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        
        let param = ["uid":userID,"access_token":accessToken]
        
        manager.GET(weiboURL, parameters: param, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            print("getWeiboUserData success\n", terminator: "")
            
            print(response)
            

            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                print("getWeiboUserData failure\n", terminator: "")
                print(error, terminator: "")
        }

        
    }
    
    
    func onResp(resp: BaseResp!) {
        if let result = resp as? SendAuthResp {
            let code = result.code
            
            let url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx6d67e31185e79352&secret=b7aa72c257097bb57cca1bc880674373&code=\(code)&grant_type=authorization_code"
            //print(url)
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFHTTPResponseSerializer()
            
            //manager.securityPolicy.allowInvalidCertificates = true
            manager.GET(url, parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                //print("success")
                
                let dic = (try! NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                //print(dic)
                if let token = dic.objectForKey("access_token") as? String {
                    if let openid = dic.objectForKey("openid") as? String {
                        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "weChat_token")
                        if let refresh_token = dic.objectForKey("refresh_token") as? String {
                            NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "weChat_refresh_token")
                        }
                        self.getUserInfo(token, openid: openid)
                    }
                } else {
                    Tool.showErrorHUD("用户取消微信授权")
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    print("failure", terminator: "")
                    print(error, terminator: "")
                    NSNotificationCenter.defaultCenter().postNotificationName("weChat_login_Failed", object: nil)
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
            

        }
        
        
        
    }
    func getUserInfo(token:String,openid:String){
        let user_url = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openid)"
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(user_url, parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            //print("success")
            let dic = (try! NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            if let openid = dic.objectForKey("openid") as? String{
                if let nickname = dic.objectForKey("nickname") as? String {
                    if let headimgurl = dic.objectForKey("headimgurl") as? String {
                        
                        let city = dic.objectForKey("city") as! String
                        let country = dic.objectForKey("country") as! String
                        let language = dic.objectForKey("language") as! String
                        let province = dic.objectForKey("province") as! String
                        let sex = dic.objectForKey("sex") as! Int
                        let unionid = dic.objectForKey("unionid") as! String
                        let privilege = dic.objectForKey("privilege") as! NSArray
                        
                        manager.securityPolicy.allowInvalidCertificates = true
                        manager.securityPolicy.validatesDomainName = false
                        let others : NSDictionary = ["city":city,"country":country,"language":language,"province":province,"sex":sex,"unionid":unionid,"privilege":privilege]
                        let userInfo : NSDictionary = ["client_id":ServerConstant.client_id,"open_id":openid,"nickname":nickname,"img_url":headimgurl,"others":others]
                        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                                let server_callback = (try! NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                                let token = server_callback.objectForKey("token") as! String
                                let refresh_token = server_callback.objectForKey("refresh_token") as! String
                                NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                                NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "refresh_token")
                            
                                NSNotificationCenter.defaultCenter().postNotificationName("weChat_login_Successed", object: nil)
                                NSNotificationCenter.defaultCenter().postNotificationName("postweChatInfo", object: nil, userInfo:["nickname":nickname,"imgURL":headimgurl])
                                NSUserDefaults.standardUserDefaults().setObject(headimgurl, forKey: "weChat_userImageUrl")
                                NSUserDefaults.standardUserDefaults().setObject(nickname, forKey: "weChat_userNickname")
                            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                                print(error, terminator: "")
                                NSNotificationCenter.defaultCenter().postNotificationName("weChat_login_Failed", object: nil)
                                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        })
                    }
                }
            }
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure", terminator: "")
                print(error, terminator: "")
        }
    }
    
   }


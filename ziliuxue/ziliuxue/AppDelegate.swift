//
//  AppDelegate.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?
    var drawerController:MMDrawerController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //textField和键盘自适应高度的开关
        IQKeyboardManager.sharedManager().enable = true
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        WXApi.registerApp("wx6d67e31185e79352")
        //ServerMethods.obtainToken("geleichen@gmail.com", password: "gelei")
        //ServerMethods.obtainNewToken(NSUserDefaults.standardUserDefaults().objectForKey("refresh_token") as! String)
        //ServerMethods.getCollege("1", to: "3")
        
       //ServerMethods.updateUserProfile("USA", degree: "master's", major: "Computer Science", gpa: 3.2, toefl: 100, sat: 2000, my_schools: ["559f599582e515e069064b4c"])
        //ServerMethods.getCollegeDetail("559f599582e515e069064b4c")
        //ServerMethods.getUserProfile()
        ServerMethods.getCollege("1", to: "10")
        //ServerMethods.getCourseOverview("TOEFL")
                
        let kMaximumLeftDrawerWidth:CGFloat = 260.0
        let leftSideDrawerViewController:LeftDrawerTableViewController = LeftDrawerTableViewController(nibName: "LeftDrawerTableViewController", bundle: nil)
        
        let centerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("centerTabView") as! CenterTabViewController
        
        
        let navigationController = UINavigationController(rootViewController: centerViewController)
        
        navigationController.navigationBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1)
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

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
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
                
                let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                //print(dic)
                if let token = dic.objectForKey("access_token") as? String {
                    if let openid = dic.objectForKey("openid") as? String {
                        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "weChat_token")
                        if let refresh_token = dic.objectForKey("refresh_token") as? String {
                            NSUserDefaults.standardUserDefaults().setObject("", forKey: "weChat_refresh_token")
                        }
                        self.getUserInfo(token, openid: openid)
                    }
                } else {
                    Tool.showErrorHUD("用户取消微信授权")
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    print("failure")
                    print(error)
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
            let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
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
                        let others = NSDictionary(objectsAndKeys: city,"city",country,"country",language,"language",province,"province",sex,"sex",unionid,"unionid",privilege,"privilege")
                        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",openid,"open_id",nickname,"nickname",headimgurl,"img_url",others,"others")
                        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                                let server_callback = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                                let token = server_callback.objectForKey("token") as! String
                                let refresh_token = server_callback.objectForKey("refresh_token") as! String
                                NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                                NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "refresh_token")
                            
                                NSNotificationCenter.defaultCenter().postNotificationName("weChat_login_Successed", object: nil)
                                NSNotificationCenter.defaultCenter().postNotificationName("postweChatInfo", object: nil, userInfo:["nickname":nickname,"imgURL":headimgurl])
                                NSUserDefaults.standardUserDefaults().setObject(headimgurl, forKey: "weChat_userImageUrl")
                                NSUserDefaults.standardUserDefaults().setObject(nickname, forKey: "weChat_userNickname")
                            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                                print(error)
                                NSNotificationCenter.defaultCenter().postNotificationName("weChat_login_Failed", object: nil)
                                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        })
                    }
                }
            }
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("failure")
                print(error)
        }
    }

    
   }


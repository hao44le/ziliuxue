//
//  Utility.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/24/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
}


struct LocalStore {
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func setIntroAsVisited() {
        userDefaults.setObject(true, forKey: "introKey")
    }
    
    static func isIntroVisited() -> Bool {
        return userDefaults.boolForKey("introKey")
    }
    
    static func isLogined()->Bool{
        return userDefaults.boolForKey("loginKey")
    }
    
    static func setLogined(){
        userDefaults.setObject(true, forKey: "loginKey")
    }
    
    
    
    
}
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct ServerMethods {
    
    
    
    static func signup(username:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"username",password,"password")
        manager.POST(ServerConstant.signup, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("signupSuccessed", object: nil)
            print("signup success")
            print(response)
            
            print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("signupFailed", object: nil)
                print("signup failure")
                print(error)
        }
        
    }
    
    
    
    static func getAllUsers(token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        manager.GET(ServerConstant.get_user, parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            print("getAllUsers success")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("getAllUsers failure")
        }
    }
    
    
    static func getCorrectBreakPoint(from:String,to:String)->String{
        return ServerConstant.get_college + from + "&num=" + to
    }
    
    static func getCollege(from:String,to:String,token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        
        manager.GET(getCorrectBreakPoint(from, to: to), parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            print("getCollege success")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("getCollege failure")
                print(error)
        }
        
    }
    
    static func obtainNewToken(refresh_token:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",refresh_token,"refresh_token")
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            print("obtainNewToken success")
            
            print(response)
        }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print("obtainNewToken failure")
                print(error)
        }
    }
    
    static func obtainToken(username:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"username",password,"password")
        
        
        
        
        manager.POST(ServerConstant.obtain_token, parameters: userInfo, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("loginSuccessed", object: nil)
            print("login success")
            
            //print(response)
            let dic = response as! NSDictionary
            let refresh_token = dic.objectForKey("refresh_token") as! String
            let token = dic.objectForKey("token") as! String
            
            
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
            NSUserDefaults.standardUserDefaults().setObject(refresh_token, forKey: "refresh_token")
            

            
            
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("loginFailed", object: nil)
                print("login failure")
                print(error)
        }
        
    }
    
    
    

}




struct ServerConstant {
    static let client_id = "c050c2c1-3ac0-46c7-abf6-e7edfb16aee4"
    static let signup = "https://livebo.cloudapp.net/api/auth/signup"
    static let obtain_token = "https://livebo.cloudapp.net/api/auth/token"
    static let get_user = "https://livebo.cloudapp.net/api/users"
    static let get_college = "https://livebo.cloudapp.net/api/colleges?ranking="
    
    
    
}




struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

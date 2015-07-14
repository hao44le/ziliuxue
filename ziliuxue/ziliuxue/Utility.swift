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
    
    
    
    static func createUserProfile(country:String,degree:String,major:String,gpa:Float,toefl:Float,sat:Float,my_schools:[String]){
        
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        let target = NSDictionary(objectsAndKeys: country,"country",degree,"degree",major,"major")
        let scores = NSDictionary(objectsAndKeys: gpa,"gpa",toefl,"toefl",sat,"sat")
        let profile = NSDictionary(objectsAndKeys: scores,"scores",target,"target",my_schools,"my_schools")
        let parameter = NSDictionary(objectsAndKeys: profile,"profile")
        print(parameter)
        
        manager.POST(ServerConstant.user_profile, parameters: parameter
            , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("createUserProfileSuccessed", object: nil)
                print("createUserProfile success")
                let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                print(dic)

            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("createUserProfileFailed", object: nil)
                print("createUserProfile failure")
                print(error)
        }
    }
    
    static func updateUserProfile(country:String,degree:String,major:String,gpa:Float,toefl:Float,sat:Float,my_schools:[String]){
        
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        let target = NSDictionary(objectsAndKeys: country,"country",degree,"degree",major,"major")
        let scores = NSDictionary(objectsAndKeys: gpa,"gpa",toefl,"toefl",sat,"sat")
        let profile = NSDictionary(objectsAndKeys: scores,"scores",target,"target",my_schools,"my_schools")
        let parameter = NSDictionary(objectsAndKeys: profile,"profile")
        print(parameter)
        
        manager.PUT(ServerConstant.user_profile, parameters: parameter
            , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("updateUserProfileSuccessed", object: nil)
                print("updateUserProfile success")
                let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                print(dic)

            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("updateUserProfileFailed", object: nil)
                print("updateUserProfile failure")
                print(error)
        }

    }
    
    static func getUserProfile(){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        
        manager.GET(ServerConstant.user_profile, parameters: nil
            , success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getUserProfileSuccessed", object: nil)
                print("getUserProfile success")
                let dic = NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                print(dic)
                //print(response)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getUserProfileFailed", object: nil)
                print("getUserProfile failure")
                print(error)
        }
    }
    
    
    static func getCollegeDetail(collegeID:String){
        let manager = AFHTTPRequestOperationManager()
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        manager.GET(getCorrectBreakPointForCollegeDetail(collegeID), parameters: nil, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeDetailSuccessed", object: nil)
                print("getCollegeDetail success")
                print(response)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeDetailFailed", object: nil)
                print("getCollegeDetail failure")
                print(error)
        }
        
        
    }
    
    static func signup(username:String,password:String){
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        let userInfo = NSDictionary(objectsAndKeys: ServerConstant.client_id,"client_id",username,"username",password,"password")
        print(userInfo)
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
    
    static func getCorrectBreakPointForCollegeDetail(schoolId:String)->String {
        return ServerConstant.get_college_detail + schoolId
    }
    
    static func getCollege(from:String,to:String){
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy.allowInvalidCertificates = true
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "x-access-token")
        
        manager.GET(getCorrectBreakPoint(from, to: to), parameters: nil, success: { (operation:AFHTTPRequestOperation!, respose:AnyObject!) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("getCollegeSuccessed", object: nil)
            print("getCollege success")
            print(respose)
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("getCollegeFailed", object: nil)
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
    static let get_college_detail = "https://livebo.cloudapp.net/api/colleges/"
    static let user_profile = "https://livebo.cloudapp.net/api/profile"
    
}




struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

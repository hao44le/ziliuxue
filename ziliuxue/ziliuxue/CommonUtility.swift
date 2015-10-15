//
//  CommonUtility.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/19.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class Utils: NSObject {
    static let mainColor = UIColor(red: 0/255, green: 135/255, blue: 218/255, alpha: 1)
    static let tabbarColor = UIColor(white: 1, alpha: 0.8)
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
    
    static func setLogout(){
        userDefaults.setObject("", forKey: "token")
        userDefaults.setObject("", forKey: "refresh_token")
        userDefaults.setObject(nil, forKey: "weChat_userImageUrl")
        userDefaults.setObject(nil, forKey: "weChat_userNickname")
        userDefaults.setObject(nil, forKey: "weChat_token")
        userDefaults.setObject(nil, forKey: "nickName")
        userDefaults.setObject(false, forKey: "loginKey")
        userDefaults.setObject(nil, forKey: "loginWay")
    }
    
    
}

//Device Info
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//Device Type
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    
}

func IS_IOS7() ->Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0 }

func IS_IOS8() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0 }

func IS_IOS9() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 9.0 }

//Color

func UIColorFromRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

func UIColorFromHexRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


//UI







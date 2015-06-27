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

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
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

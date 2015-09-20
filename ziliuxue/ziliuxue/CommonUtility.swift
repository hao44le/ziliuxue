//
//  CommonUtility.swift
//  ziliuxue
//
//  Created by WangShuo on 15/9/19.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class CommonUtility: NSObject {

}

//Device Info
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
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







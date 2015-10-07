//
//  LogFormatter.swift
//  ParseStarterProject-Swift
//
//  Created by Gelei Chen on 2/10/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
class LogFormatter:NSObject,DDLogFormatter {
    func formatLogMessage(logMessage: DDLogMessage!) -> String! {
       
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let str = dateFormatter.stringFromDate(logMessage.timestamp)
        
        let logDict : NSDictionary = ["timeStamp":str,"level":logMessage.flag.rawValue,"message":logMessage.message]
        
        do {
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(
                logDict ,options: NSJSONWritingOptions.init(rawValue: 0))
            let theJSONText = String(data: theJSONData,
                encoding: NSASCIIStringEncoding)
            return theJSONText
        } catch {
            print("error")
        }
        return "error"
    }
}
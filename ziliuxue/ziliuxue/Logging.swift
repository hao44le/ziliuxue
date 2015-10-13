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
class LocalFileManager : NSObject {
    private static func deleteFileAtPath(file:DDLogFileInfo){
        if file.status == "uploaded" {
            //delete
            do {
                if NSFileManager.defaultManager().fileExistsAtPath(file.filePath){
                    try NSFileManager.defaultManager().removeItemAtPath(file.filePath)
                }
                
            } catch {
                
            }
            
            
        } else {
            print("file is not uploaded!")
        }
        
        
    }
    static func uploadFileAtPath(path:String){
        
        let file = DDLogFileInfo(filePath: path)
        if (file.status == nil)||(file.status == "upload failed") {
            file.status = "uploading"
            
            //upload file
            
            //            let file = PFFile(name: "2.gz", contentsAtPath: path)
            //            file.saveInBackground()
            //            let object = PFObject(className: "Gelei")
            //            object["file"] = file
            //            object.saveInBackgroundWithBlock { (succed:Bool, error:NSError?) -> Void in
            //                if succed {
            //                    //print(succed)
            //                     file.status = "uploaded"
            //                    LocalFileManager.deleteFileAtPath(file)
            //                } else {
            //                    //print(succed)
            //                     file.status = "upload failed"
            //                }
            //            }
            //
            
        }
        
        
        
    }
}

class Logging :NSObject{
    
    // MARK : Setup logger
    static func setUpLogger(){
        
        let logFileManager = CompressingLogFileManager()
        let fileLogger = DDFileLogger(logFileManager: logFileManager)
        fileLogger!.maximumFileSize = 1024*1024*3  // 3 MB
        fileLogger!.rollingFrequency = 60*10 // 10 minutes
        fileLogger!.logFileManager.maximumNumberOfLogFiles = 100
        fileLogger!.logFormatter = LogFormatter()
        NSUserDefaults.standardUserDefaults().setObject(fileLogger!.logFileManager.logsDirectory(), forKey: "logDirectory")
        DDLog.addLogger(DDASLLogger.sharedInstance())
        DDLog.addLogger(DDTTYLogger.sharedInstance())
        DDLog.addLogger(fileLogger)
        
        
    }
    func uploadRemaninggzFile(){
        let string = checkLocalgzFile()
        if string.count == 0 {
            print("logDirectory doesn't exist")
        } else {
            self.upLoadAndDeleteLocalgzFile(string)
        }
        
        
    }
    
    // MARK : Return local gz File directory. If gz file doesn't exist, return an empty array
    private func checkLocalgzFile()->[String]{
        let fileManager = NSFileManager.defaultManager()
        let logsPath = NSUserDefaults.standardUserDefaults().objectForKey("logDirectory") as! String
        do {
            let docsArray = try fileManager.contentsOfDirectoryAtPath(logsPath)
            //print(docsArray)
            let gzFileExtension = ".gz"
            let gzArray = docsArray.filter({(item: String) -> Bool in
                let stringMatch = item.lowercaseString.rangeOfString(gzFileExtension.lowercaseString)
                return stringMatch != nil ? true : false
            })
            //print(gzArray)
            return gzArray
            
        } catch {
            print("logDirectory doesn't exist")
        }
        return []
    }
    
    // MARK : Upload gz file. If succeed call LocalFileManager to delete the file, else do nothing.
    private func upLoadAndDeleteLocalgzFile(gzArray:[String]){
        let logsPath = NSUserDefaults.standardUserDefaults().objectForKey("logDirectory") as! String
        for gzfileName in gzArray {
            let filePath = "\(logsPath)/\(gzfileName)"
            LocalFileManager.uploadFileAtPath(filePath)
        }
    }
    
    
    
    
}

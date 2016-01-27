//
//  MySchoolServer.swift
//  ziliuxue
//
//  Created by Gelei Chen on 21/11/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import Foundation
class MySchoolServer: NSObject {
    
   
    
    static func querySchoolRankList(completeBlock:(schoolRankListItem:SchoolRankListItem?) -> Void){
        
        let manager = NetWorkManager()
        manager.requestSerializer.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNTYzMWMxNmUyYjhhMzA3Yjg2ZDIzNzBmIiwib3Blbl9pZCI6ImZvbzQiLCJzb2NpYWxfbmV0d29yayI6IndlY2hhdCIsInR5cGUiOiJqd3QiLCJpYXQiOjE0NDcxMjcxNDEsImV4cCI6MTQ0NzczMTk0MX0.NbquZOZvQxn_3j1e8gRuoZa1uP0hVkaqKgIzU4VWy7k", forHTTPHeaderField: "x-access-token")
        manager.requestSerializer.setValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
        let param = ["school_id":"56416804ebdb17a728412074"]
      
        do {
            let theJSONData =  try NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions(rawValue:0))
            let theJSONText = NSString(data: theJSONData,
                encoding: NSASCIIStringEncoding)
            
            manager.POST(ServerConstant.getMySchoolApiBreakPoint(), parameters: theJSONText!, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                print(response)
                //json解密转换成Item 传入block
                completeBlock(schoolRankListItem: nil)
                }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    print(error)
                    
            }
        } catch {
            
        }
        
        
        
    }
}

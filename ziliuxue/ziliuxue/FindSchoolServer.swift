//
//  FindSchoolServer.swift
//  ziliuxue
//
//  Created by WangShuo on 15/11/2.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

// Global and static properties are already dispatch_once'd, so there's really no need for this. You can simply define the singleton instance as a global variable or static let property of a struct. - From jckarter: devforums.apple.com/thread/229436

import UIKit

class FindSchoolServer: NSObject {

    static let sharedInstance = FindSchoolServer()
    
    func querySchoolRankList(URL:String!,pageSize:String!,pageNum:String!,completeBlock:(schoolRankListItem:SchoolRankListItem?) -> Void){
        
        let manager = NetWorkManager()
        
        let param = ["pageSize":pageSize,"pageNum":pageNum]
        
        manager.POST(URL, parameters: param, success: { (operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            
            //json解密转换成Item 传入block
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                completeBlock(schoolRankListItem: nil)
        }
        
    }
}

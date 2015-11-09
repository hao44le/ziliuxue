//
//  LoginBarrier.swift
//  ziliuxue
//
//  Created by WangShuo on 15/11/9.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class LoginBarrier: NSObject {

    func checkLoginAndDoBlock(block:() -> Void){
        
        if self.hasLoggedIn(){
            block()
        }else{
            
            
        }
        
    }
    
    func hasLoggedIn() -> Bool{
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("token") as? String
        
        if nil != token{
            return true
        }else{
            return false
        }
    }
}

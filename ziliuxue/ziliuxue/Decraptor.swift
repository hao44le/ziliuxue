//
//  Decraptor.swift
//  ziliuxue
//
//  Created by Gelei Chen on 21/11/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import Foundation
import RNCryptor

class Decraptor : NSObject {
    static let password = "42s5DE6RP14u8C558AMZZnTeBeN4kZ4O"
    
    
    class func decrapte(input:String) -> String {
        let decodedData = NSData(base64EncodedString: input, options: NSDataBase64DecodingOptions(rawValue: 0))
        do {
            let originalData = try RNCryptor.decryptData(decodedData!, password: password)
            let string2 = NSString(data: originalData, encoding: NSUTF8StringEncoding)
            print(string2)
            if let result = string2 as? String {
                return result
            }
        } catch {
            
        }
        return "error"
    }
}
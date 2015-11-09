//
//  MandatoryLoginController.swift
//  ziliuxue
//
//  Created by WangShuo on 15/11/9.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

extension DefaultsKeys {
    static let schoolDetailSeenTimesCount = DefaultsKey<Int?>("schoolDetailSeenTimesCount")
}

class MandatoryLoginController: NSObject {

    func getSchoolDetailSeenTimes() -> Int{
        var schoolDetailSeenTimes = Defaults[DefaultsKeys.schoolDetailSeenTimesCount]
        
        if nil == schoolDetailSeenTimes{
            Defaults[DefaultsKeys.schoolDetailSeenTimesCount] = 0
            schoolDetailSeenTimes = 0
            return 0
            
        }else{
            return schoolDetailSeenTimes!
        }
    }
    
    func addSchoolDetailSeenTimes(){

        Defaults[DefaultsKeys.schoolDetailSeenTimesCount]!++
    }
}

//
//  CourseDetail.swift
//  ziliuxue
//
//  Created by Wangshuo on 7/18/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import Foundation


class CourseDetail: NSObject {

    
    var _id : String!
    var name : String!
    var overview : NSDictionary!
    var sessions : NSArray!
    var metadata: NSDictionary!
    
    
    
    init(_id:String, name:String,sessions:NSArray)
    {
        self._id = _id
        self.name = name
        self.sessions = sessions
    }
    
}
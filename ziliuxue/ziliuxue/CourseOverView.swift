//
//  CourseOverView.swift
//  ziliuxue
//
//  Created by Wangshuo on 7/18/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import Foundation


class CourseOverView: NSObject {
    
    var _id : String!
    var courseName : String!
    var coursePicURL : String!
    var teacherPicURL : String!
    var teacherName  : String!
    var location  : String!
    var favNum  : NSInteger!
    var price  : NSInteger!
    var metadata : NSDictionary!
    var overview : NSDictionary!
    

     init(_id:String,metadata:NSDictionary,overview:NSDictionary,courseName:String,coursePicURL:String,teacherPicURL:String,teacherName:String,location:String,favNum:NSInteger,price:NSInteger)
    {
        self._id = _id
        self.metadata = metadata
        self.overview = overview
        self.courseName = courseName
        self.coursePicURL = coursePicURL
        self.teacherPicURL = teacherPicURL
        self.teacherName = teacherName
        self.location = location
        self.favNum = favNum
        self.price = price
    }
    
}



//{"_id":"55a7190b452c74914dd42a85","name":"北京李湘TOEFL写作班","overview":{"category":"TOEFL","subtitle":"写作课程和一对一咨询","location":"北京 海淀区","introduction":"李湘老师曾获得美国芝加哥大学教育博士学位，她已经提供了3年的TOEFL写作课程，80%的学生获得95%以上的高分。写作班每周一次4小时，讲解和联系相结合，使学生的写作在12次的课次中有显著的提高。该课程从每个季度开始。","level":"400","favs":3569,"teacher":{"name":"李湘","avatar":"/public/img/avatar.lixiang.png"},"photos":["/public/img/course1.1.png","/public/img/course1.2.png","/public/img/course1.3.png"]},"metadata":{"favs":3569,"category":"TOEFL","subcategory":"写作","level":400,"price":899}}
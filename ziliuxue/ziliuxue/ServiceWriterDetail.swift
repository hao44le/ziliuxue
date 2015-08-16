//
//  ServiceWriterDetail.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/15/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import Foundation


class ServiceWriterDetail: NSObject {
    
    var _id : String!
    var name : String!
    var avatar_url : String!
    var title : String!
    var summary  : String!
    var category : String!
    var completed_cases : NSInteger!
    var years_in_service : String!
    var favs : NSInteger!
    var comments:NSArray!
    var services:NSArray!
    var samples:NSArray!
    
  
}


//{
//    "_id": "55c949b958ef03209890b4c6",
//    "name": "Stephenie An",
//    "avatar_url": "/public/img/writer1.png",
//    "title": "写手",
//    "summary": "计算机，电子工程，信息系统类的个人声明和简历",
//    "category": "resume",
//    "description": "Stephenie An is a senior Ph.D student in the University of Michigan, Ann Arbor. He is specialized in Chemical Engineering and Informatics. He has been actively helping other Chinese students to prepare for graduate school applications for over 3 years.",
//    "completed_cases": 398,
//    "years_in_service": "3年",
//    "favs": 278,
//    "__v": 0,
//    "services": [
//    {
//    "name": "个人简历",
//    "description": "包括2次电话会谈和2次修改",
//    "targets": "本科，硕士研究生，或工业界找工作",
//    "format": "Word, PDF或其他通用格式",
//    "time": "2周",
//    "price": 799,
//    "_id": "55c949b958ef03209890b4c7"
//    }
//    ],
//    "samples": [
//    {
//    "area": "化学",
//    "description": "针对化学理论专业",
//    "_id": "55c949b958ef03209890b4cb"
//    },
//    {
//    "area": "化工",
//    "description": "针对化工材料专业",
//    "_id": "55c949b958ef03209890b4ca"
//    },
//    {
//    "area": "信息",
//    "description": "针对化学化工类信息工程",
//    "_id": "55c949b958ef03209890b4c9"
//    },
//    {
//    "area": "计算机",
//    "description": "针对计算机应用和人工智能",
//    "_id": "55c949b958ef03209890b4c8"
//    }
//    ],
//    "comments": [
//    "超强写作老师。条理超清晰，循序渐进，提高很快。",
//    "超强的写作老师，我的OFFER可以100%归功于Ken Wang.",
//    "太牛，太值了。超强，超过块，超幽默！"
//    ]
//}
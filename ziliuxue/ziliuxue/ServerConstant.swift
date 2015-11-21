//
//  Utility.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/24/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit


struct ServerConstant {
    
    private static let baseURL = "https://derun.cloudapp.net"
    private static let wechat_signout = "\(baseURL)/oauth/v1/wechat/signout"
    private static let wechat_obtain_token = "\(baseURL)/oauth/v1/wechat/signin"
    private static let postMyCollege = "\(baseURL)/oauth/v1/my/schools"
    private static let new_token = "\(baseURL)/oauth/v1/refreshtoken"
    private static let deleteCollege = "\(baseURL)/oauth/v1/my/schools/"
    private static let get_college = "\(baseURL)/oauth/v1/schools?ranking=usnews"
    private static let get_college_detail = "\(baseURL)/oauth/v1/schools/"
    private static let get_my_school = "\(baseURL)/oauth/v1/my/schools"
    
    
    static func getSignoutApiBreakPoint()->String{
        return wechat_signout
    }
    static func getTokenBreakApiPoint()->String{
        return wechat_obtain_token
    }
    static func getPostMyCollegeApiBreakPoint()->String{
        return postMyCollege
    }
    static func getRefreshTokenApiBreakPoint()->String{
        return new_token
    }
    static func getDeleteCollegeBreakPoint(schoolId:String)->String{
        return deleteCollege + schoolId
    }
    static func getCollegeRankingBreakPoint(pageNum:String,pageSize:String)->String{
        return ServerConstant.get_college + "&pagenum=" + pageNum + "&pagesize=" + pageSize
    }
    
    static func getCollegeDetailBreakPoint(schoolId:String)->String {
        return ServerConstant.get_college_detail + schoolId
    }
    static func getMySchoolApiBreakPoint()->String{
        return get_my_school
    }
    
    
    
}








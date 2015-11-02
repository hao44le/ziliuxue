//
//  StringProcess.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/30.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import Foundation


//字符串数组返回按拼音首字母排好序的字符串

func sortedStringByPinYinFirstChar(stringsToSort:NSArray)->NSArray{
    let chineseStringsArray = NSMutableArray()
    
    for i in 0..<stringsToSort.count{
        let chineseString = ChineseString()
        chineseString.originalString = String(stringsToSort.objectAtIndex(i))
        
        if nil == chineseString.originalString{
            chineseString.originalString = ""
        }
        
        if !(chineseString.originalString == "") {
            let pinYinResult = NSMutableString()
            for j in 0..<chineseString.originalString.length{

                let string:NSString = chineseString.originalString
                
                let singlePinyinLetter = NSString(format: "%c", pinyinFirstLetter(string.characterAtIndex(j))).uppercaseString
                pinYinResult.appendString(singlePinyinLetter)
            }
            chineseString.pinYin = pinYinResult as String
        }else{
            chineseString.pinYin = ""
        }
        chineseStringsArray.addObject(chineseString)
    }
    
    //按照拼音首字母对这些Strings进行排序
    let sortDescriptors = NSArray(array: [NSSortDescriptor(key: "pinYin", ascending: true)])
    chineseStringsArray.sortUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
    
    
    let resultArray = NSMutableArray()
    for i in 0..<chineseStringsArray.count{
        let chineseString = chineseStringsArray[i] as! ChineseString
        resultArray.addObject(chineseString.originalString)
    }
    
    return resultArray
    
}




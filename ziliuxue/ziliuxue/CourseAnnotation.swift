//
//  MyAnnotation.swift
//  componentTest
//
//  Created by WangShuo on 15/7/20.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//
import UIKit
import Foundation
import MapKit

class CourseAnnotation:NSObject,MKAnnotation
{
    var coordinate : CLLocationCoordinate2D
    var title : String
    var subtitle : String
    var image : UIImage
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String,image:UIImage) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
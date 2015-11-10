//
//  SchoolRankCell.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/24.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankCell: UITableViewCell {

    
    @IBOutlet var schoolLogoImage: UIImageView!
    
    @IBOutlet var schoolRankNumImage: UIImageView!
    
    @IBOutlet var schoolChineseNameLabel: UILabel!

    @IBOutlet var schoolEngNameLabel: UILabel!
    
    @IBOutlet var actionButton: UIButton!
    
    @IBOutlet var rankNumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithItem(item:SchoolRankListItem){
        
        if 0 == item.schoolRankNum.integerValue{
            
            self.schoolRankNumImage.image = UIImage(named: "school_list_no1")
        }else if 1 == item.schoolRankNum.integerValue{
            self.schoolRankNumImage.image = UIImage(named: "school_list_no2")
        }else if 2 == item.schoolRankNum.integerValue{
            self.schoolRankNumImage.image = UIImage(named: "school_list_no3")
        }else {
            self.schoolRankNumImage.image = UIImage(named: "school_list_no")
        }
        
        self.schoolChineseNameLabel.text = item.schoolChineseName as String
        self.schoolEngNameLabel.text = item.schoolEnglishName as String
        self.rankNumLabel.text = item.schoolRankNum as String
        
//        self.schoolLogoImage.sd_setImageWithURL(<#T##url: NSURL!##NSURL!#>, placeholderImage: UIImage(named: "school_list_no"))
        
        
    }
    

}

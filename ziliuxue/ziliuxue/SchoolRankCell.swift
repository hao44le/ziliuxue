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

}

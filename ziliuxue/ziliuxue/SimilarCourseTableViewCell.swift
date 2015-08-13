//
//  SimilarCourseTableViewCell.swift
//  ziliuxue
//
//  Created by Wangshuo on 7/18/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class SimilarCourseTableViewCell: UITableViewCell {

    
    @IBOutlet var avatarImageView: UIImageView!
    
    @IBOutlet var courseName: UILabel!
    
    @IBOutlet var courseDetail: UILabel!
    
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

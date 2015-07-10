//
//  SimilarCourseTableViewCell.swift
//  ziliuxue
//
//  Created by Gelei Chen on 7/10/15.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class SimilarCourseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teacherImage: UIImageView!
    
    @IBOutlet weak var courseTitle: UILabel!
    
    @IBOutlet weak var courseDetail: UILabel!
    
    @IBOutlet weak var courseTuition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

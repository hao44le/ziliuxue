//
//  CourseTableViewCell.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    
    
    @IBOutlet var teacherImage: UIImageView!
    
    @IBOutlet var courseImage: UIImageView!
    
    
    @IBOutlet var couseName: UILabel!
    
    
    @IBOutlet var courseDetail: UILabel!
    
    
    @IBOutlet var coursePrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

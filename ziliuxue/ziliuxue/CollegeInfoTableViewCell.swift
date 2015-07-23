//
//  CollegeInfoTableViewCell.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class CollegeInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var applicationConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var academicInfoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var costInfoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collegeInfoConstraint: NSLayoutConstraint!
        @IBOutlet weak var firstLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var rightLabel: UILabel!
   
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

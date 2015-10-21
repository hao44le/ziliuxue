//
//  PersonalInfoTableViewCell.swift
//  ziliuxue
//
//  Created by Gelei Chen on 20/10/2015.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

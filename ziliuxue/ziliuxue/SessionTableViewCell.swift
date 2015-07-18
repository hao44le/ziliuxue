//
//  SessionTableViewCell.swift
//  ziliuxue
//
//  Created by Wangshuo on 7/19/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    
    
    @IBOutlet var sessionDetail: UILabel!
    
    
    @IBOutlet var sessionAddButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

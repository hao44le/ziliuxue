//
//  FirstTabTableViewCell.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class FirstTabTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pieView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

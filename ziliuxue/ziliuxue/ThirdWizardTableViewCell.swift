//
//  WizardTableViewCell.swift
//  
//
//  Created by Gelei Chen on 6/23/15.
//
//

import UIKit

class ThirdWizardTableViewCell: UITableViewCell {

    @IBAction func likeClicked(sender: UIButton) {
    }
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var accptionRate: UILabel!
    @IBOutlet weak var tuition: UILabel!
    @IBOutlet weak var universityLocation: UILabel!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var ranking: UILabel!
    @IBOutlet weak var logo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

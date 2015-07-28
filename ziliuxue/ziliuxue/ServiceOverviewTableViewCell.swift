//
//  ServiceOverviewTableViewCell.swift
//  
//
//  Created by Gelei Chen on 7/28/15.
//
//

import UIKit

class ServiceOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var teacherImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

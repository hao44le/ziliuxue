//
//  WizardTableViewCell.swift
//  
//
//  Created by Gelei Chen on 6/23/15.
//
//

import UIKit

class ThirdWizardTableViewCell: UITableViewCell {

    @IBOutlet weak var starImage: UIImageView!
    @IBAction func likeClicked(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey(self.universityName.text!){
            //取消收藏
            
            
            
            defaults.setBool(false, forKey: self.universityName.text!)
            self.starImage.image = UIImage(named: "star")
            
            
            
            
            
            
            
        } else {
            //收藏
            
            
            
            self.starImage.image = UIImage(named: "star_filled")
            defaults.setBool(true, forKey: self.universityName.text!)
            
            
            
            
            
        }
        
        
        
        
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

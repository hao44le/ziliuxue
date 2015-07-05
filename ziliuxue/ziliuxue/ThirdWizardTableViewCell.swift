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
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.universityName.text!, forKey: "currentCelectedSchool")
        var number = defaults.integerForKey("numberOfFavoritedSchool")
        
        if defaults.boolForKey(self.universityName.text!){
            //取消收藏
            
            //print("remove")
            
            
            NSNotificationCenter.defaultCenter().postNotificationName("removeTopPicture", object: nil)
            
            if number > 0 {
                defaults.setInteger(--number, forKey:"numberOfFavoritedSchool")
            }
            
            
            
            defaults.setBool(false, forKey: self.universityName.text!)
            self.like.setImage(UIImage(named: "star"), forState: UIControlState.Normal)

            
            
            
        } else {
            //收藏
            
            //print("add")
            
            
            
            if number == 0{
                
                defaults.setInteger(1, forKey: "numberOfFavoritedSchool")
               
            } else {
                if number < 3 {
                    defaults.setInteger(++number, forKey: "numberOfFavoritedSchool")
                } else {
                    let ac = UIAlertView(title: "最多可以选择3选学校", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                    return
                }
            }
            
            self.like.setImage(UIImage(named: "star_filled"), forState: UIControlState.Normal)
            defaults.setBool(true, forKey: self.universityName.text!)
            
            NSNotificationCenter.defaultCenter().postNotificationName("addTopPicture", object: nil)
            
            
            
            
            
            
            
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

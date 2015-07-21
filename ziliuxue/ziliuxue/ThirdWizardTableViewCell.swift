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
        let notification = NSNotificationCenter.defaultCenter()
        //判断收藏与否
        //
        
        if self.like.currentImage == UIImage(named: "star") {
            //print("star")
            
            //收藏
            
            
            if (defaults.objectForKey("firstUniversity") != nil) {
                if (defaults.objectForKey("secondUniversity") != nil) {
                    if (defaults.objectForKey("thirdUniversity") != nil) {
                        //加的太多
                        let ac = UIAlertView(title: "最多可以选择3选学校", message: nil, delegate: nil, cancelButtonTitle: "好的")
                        ac.show()
                        return
                    } else {
                        //加入到第三个之中
                        defaults.setObject(self.universityName.text, forKey: "thirdUniversity")
                        notification.postNotificationName("addCurrentUniversityToThirdUniversity", object: nil)
                        //return
                    }
                } else {
                    //加入到第二个之中
                    defaults.setObject(self.universityName.text, forKey: "secondUniversity")
                    notification.postNotificationName("addCurrentUniversityToSecondUniversity", object: nil)
                    //return
                }
            } else {
                //加入到第一个之中
                defaults.setObject(self.universityName.text, forKey: "firstUniversity")
                notification.postNotificationName("addCurrentUniversityToFirstUniversity", object: nil)
                //return
            }
            
            self.like.setImage(UIImage(named: "star_filled"), forState: UIControlState.Normal)
            
        } else {
            //print("star-filled")
            
            
            //取消收藏
            
            
            
            // 找到用户当前选择的学校是第几个
            // 把用户当前选择的学校减去
            
            
            let first: AnyObject? = defaults.objectForKey("firstUniversity")
            let second: AnyObject? = defaults.objectForKey("secondUniversity")
            let third: AnyObject? = defaults.objectForKey("thirdUniversity")

            if first != nil {
                if self.universityName.text == (first as! String) {
                    //就出现在第一个位置
                    if second != nil {
                        if third != nil {
                            //第一位删除，把第二三位向第一位移动一格
                            defaults.setObject(second, forKey: "firstUniversity")
                            defaults.setObject(third, forKey: "secondUniversity")
                            defaults.setObject(nil, forKey: "thirdUniversity")
                            notification.postNotificationName("deleteFirstUniversityAndMoveOthersDown", object: nil)
                        } else {
                            //第一位删除，把第二位想第一位移动一格
                            defaults.setObject(second, forKey: "firstUniversity")
                            defaults.setObject(nil, forKey: "secondUniversity")
                            notification.postNotificationName("deleteFirstUniversityAndMoveSecondDown", object: nil)
                        }
                        
                        
                        
                        
                    } else {
                        //后面都是空的，直接把第一位删除
                        defaults.setObject(nil, forKey: "firstUniversity")
                        notification.postNotificationName("deleteFirstUniversity", object: nil)
                    }
                }
            }
            
            if second != nil {
                if self.universityName.text == (second as! String) {
                    //出现在第二个位置
                    if third != nil {
                        //第二位删除，把第三位向第二位移动一格
                        defaults.setObject(third, forKey: "secondUniversity")
                        defaults.setObject(nil, forKey: "thirdUniversity")
                        notification.postNotificationName("deleteSecondUniversityAndMoveThirdUniversityDown", object: nil)
                    } else {
                      //第三个是空的，直接把第二位删除
                        defaults.setObject(nil, forKey: "secondUniversity")
                        notification.postNotificationName("deleteSecondUniversity", object: nil)
                    }
                    
                }
            }
            
            if third != nil {
                if self.universityName.text == (third as! String) {
                    //出现在第三个位置,把第三位删除
                    defaults.setObject(nil, forKey: "thirdUniversity")
                    notification.postNotificationName("deleteThirdUniversity", object: nil)
                }
            }
            
            
            
            self.like.setImage(UIImage(named: "star"), forState: UIControlState.Normal)
            
            
        }
        
        
        
        
        
        
        
        /*
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
        
        
       */
        
        
        
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

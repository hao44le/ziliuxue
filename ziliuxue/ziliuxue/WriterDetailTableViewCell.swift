//
//  WriterDetailTableViewCell.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/9/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class WriterDetailTableViewCell: UITableViewCell {

    var itemLabel:UILabel?
    var detailLabel:UILabel?
    var priceLabel:UILabel?
    var button:UIButton?
    var hasPrice:Bool?
    var hasButton:Bool?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var backgroundView = UIView(frame: CGRectMake(0, 0, 70, 40))
        backgroundView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.addSubview(backgroundView)
        
        self.itemLabel = UILabel(frame: CGRectMake(5, 0, 60, 40))
        self.backgroundView?.addSubview(self.itemLabel!)
        
        if self.hasPrice == true
        {
            print("==========")
        }
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

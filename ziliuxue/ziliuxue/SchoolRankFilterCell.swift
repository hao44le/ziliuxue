//
//  SchoolRankFilterCell.swift
//  ziliuxue
//
//  Created by WangShuo on 15/10/30.
//  Copyright © 2015年 ziliuxue. All rights reserved.
//

import UIKit

class SchoolRankFilterCell: UITableViewCell {

    
    var label:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.selectionStyle = .None
        
        self.label = UILabel(frame: CGRectMake(15,0,ScreenSize.SCREEN_WIDTH - 30,self.frame.height))
        self.label.textAlignment = NSTextAlignment.Center
        self.label.textColor = UIColor(white: 1, alpha: 1)
        self.addSubview(self.label)
        
    }

    required init?(coder aDecoder: NSCoder) {
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

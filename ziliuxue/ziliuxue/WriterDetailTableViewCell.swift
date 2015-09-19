//
//  WriterDetailTableViewCell.swift
//  ziliuxue
//
//  Created by Wangshuo on 8/9/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//

import UIKit

class WriterDetailTableViewCell: UITableViewCell {

    var itemLabel:UILabel!
    var detailLabel:UILabel!
    var priceLabel:UILabel!
    var button:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let backgroundView = UIView(frame: CGRectMake(0, 0, 70, 40))
        backgroundView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.addSubview(backgroundView)
        
        self.itemLabel = UILabel(frame: CGRectMake(10, 0, 60, 40))
        self.itemLabel?.font = UIFont(name: "Helvetica", size: 15)
        self.addSubview(self.itemLabel!)
        
        self.detailLabel = UILabel(frame: CGRectMake(75, 0, 250, 40))
        self.detailLabel?.font = UIFont(name: "Helvetica", size: 15)
        self.addSubview(self.detailLabel)
        
        self.priceLabel = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 130, 0, 80, 40))
        self.priceLabel?.font = UIFont(name: "Helvetica", size: 15)
        self.addSubview(self.priceLabel)
        
        self.button = UIButton(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 70, 5, 60, 30))
        self.addSubview(self.button)
    
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

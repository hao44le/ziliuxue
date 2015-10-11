//
//  FirstTabTableViewCell.swift
//  
//
//  Created by Gelei Chen on 7/6/15.
//
//

import UIKit

class FirstTabTableViewCell: UITableViewCell{

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailTextView: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var percentLabel: UILabel!
    
    var pieChartColor = [UIColor(red: 162/250, green: 49/250, blue: 59/250, alpha: 1),UIColor.darkGrayColor()]
    var slice:[Int]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        pieView.pieRadius = 25
        pieView.startPieAngle = CGFloat(M_PI_2)
        pieView.animationSpeed = 1.5
        pieView.dataSource = self
        pieView.pieCenter = CGPointMake(40,40)
        pieView.labelRadius = 0
        */
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    // MARK: PieChart DataSource
//    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
//        return UInt(self.slice!.count)
//    }
//    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
//        return self.pieChartColor[Int(index)]
//    }
//    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
//        return CGFloat(self.slice![Int(index)])
//    }
//    
//    func pieChart(pieChart: XYPieChart!, textForSliceAtIndex index: UInt) -> String! {
//        return ""
//    }
//

}

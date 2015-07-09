//
//  NewsUpdateViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class NewsUpdateViewController: UIViewController,XYPieChartDataSource,XYPieChartDelegate {

    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! - 1
    }
    @IBOutlet weak var pieView: XYPieChart!
    var pieChartValue = [CGFloat(1),CGFloat(3)]
    var pieChartColor = [UIColor.brownColor(),UIColor.brownColor(),UIColor.brownColor(),UIColor.brownColor(),UIColor.brownColor()]
    var slices = [27,69,73,58,30]

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.pieView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pieView.dataSource = self
        self.pieView.delegate = self
        self.pieView.startPieAngle = CGFloat(M_PI_2)
        self.pieView.animationSpeed = 1.0
        //self.pieView.labelRadius = 160
        //self.pieView.showPercentage = true
        //self.pieView.pieCenter = CGPointMake(150, 150)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: PieChart DataSource
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
    return UInt(self.slices.count)
    }
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
    return self.pieChartColor[Int(index)]
    }
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
    return CGFloat(self.slices[Int(index)])
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

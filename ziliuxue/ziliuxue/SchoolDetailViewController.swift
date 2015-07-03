//
//  SchoolDetailViewController.swift
//  ziliuxue
//
//  Created by Gelei Chen on 6/28/15.
//  Copyright © 2015 ziliuxue. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController,SwipeViewDataSource,SwipeViewDelegate{

    @IBOutlet weak var universityDescription: UITextView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var swipeView: SwipeView!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.pagingEnabled = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: SwipeView
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 3
    }
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, var reusingView view: UIView!) -> UIView! {
        if view == nil {
            view = UIView(frame: swipeView.bounds)
            let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: "Map Icon")
            view.addSubview(imageView)
        } else {
            
        }
        return view
    }
    
    func swipeViewItemSize(swipeView: SwipeView!) -> CGSize {
        return self.swipeView.bounds.size
    }
    
    func swipeViewCurrentItemIndexDidChange(swipeView: SwipeView!) {
        self.pageControl.currentPage = swipeView.currentPage
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

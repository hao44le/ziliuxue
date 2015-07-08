//
//  OverviewSchoolTabViewController.swift
//  
//
//  Created by Gelei Chen on 7/8/15.
//
//

import UIKit

class OverviewSchoolTabViewController: UIViewController,SwipeViewDataSource {

    @IBOutlet weak var universityDescription: UITextView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var swipeView: SwipeView!
    
    
    let image = ["classroom","classroom2","universityBack"]
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.pagingEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
       
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
    }
    
     // MARK: SwipeView
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        return 3
    }
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        let created = UIView(frame: swipeView.bounds)
        let imageView = UIImageView(frame: created.bounds)
        imageView.image = UIImage(named: image[index])
        created.addSubview(imageView)
        
        return created
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

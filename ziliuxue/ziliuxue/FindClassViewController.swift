//
//  FindClassViewController.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class FindClassViewController: RPSlidingMenuViewController{

    let name = ["TOEFL","IELTS","GRE","GMAT","LSAT"]
    let imageName = ["1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.featureHeight = 290.0
        self.collapsedHeight = 100.0
        //self.view.frame = CGRectMake(0, 60, ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        //self.collectionView?.contentInset = UIEdgeInsetsMake(0, 20, 0, 0)
        //self.collectionView?.contentOffset = CGPointMake(0, 64)
        
        /*
        let layout = MPSkewedParallaxLayout()
        layout.lineSpacing = 10
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 350)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(MPSkewedCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
        */

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        self.collectionView?.scrollIndicatorInsets.top = 20
    }
    override func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //scrollView.scrollIndicatorInsets.top = 0
        //print(scrollView.scrollIndicatorInsets.top)
    }
    
    override func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        print("1")
    }
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
         self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        
        let selectedIndex = self.tabBarController?.selectedIndex
        self.tabBarController?.selectedIndex = selectedIndex! + 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfItemsInSlidingMenu() -> Int {
        return name.count
    }
    override func customizeCell(slidingMenuCell: RPSlidingMenuCell!, forRow row: Int) {
        slidingMenuCell.textLabel.text = name[row]
        slidingMenuCell.backgroundImageView.image = UIImage(named: "image1_320x210")
        slidingMenuCell.detailTextLabel.text = "For you loved ones"
        
    }
    override func slidingMenu(slidingMenu: RPSlidingMenuViewController!, didSelectItemAtRow row: Int) {
        super.slidingMenu(slidingMenu, didSelectItemAtRow: row)
        self.performSegueWithIdentifier("toCourse", sender: self)
    }
    
    
    /*
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.name[indexPath.row]
        return cell
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toCourse", sender: self)
    }

    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

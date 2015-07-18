//
//  FindClassViewController.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class FindClassViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var parallaxCollectionView: UICollectionView!
    let name = ["TOEFL","IELTS","GRE","GMAT","LSAT"]
    let image = ["TOEFL_","IELTS_","GRE_","GMAT_","LSAT_"]
    
    let IMAGE_HEIGHT : CGFloat = 200
    let IMAGE_OFFSET_SPEED : CGFloat = 25
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parallaxCollectionView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.parallaxCollectionView.reloadData()
        // Do any additional setup after loading the view.
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
    
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /*
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FindClassCollectionViewCell
        cell.label.text = self.name[indexPath.row]
        cell.layer.cornerRadius = 62
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        return cell
        */
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MJCell", forIndexPath: indexPath) as! MJCollectionViewCell
        //cell.frame = CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, ScreenSize.SCREEN_WIDTH, 160)
        cell.image = UIImage(named: image[indexPath.row])
        cell.textLabel.text = name[indexPath.row]
        
        let yOffset = ((collectionView.contentOffset.y - cell.frame.origin.y) / self.IMAGE_HEIGHT) * self.IMAGE_OFFSET_SPEED
        cell.imageOffset = CGPointMake(0, yOffset)
        
       return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
        self.performSegueWithIdentifier("toCourse", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(ScreenSize.SCREEN_WIDTH, 160)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for view in self.parallaxCollectionView.visibleCells() {
            if let cell = view as? MJCollectionViewCell {
                let yOffset : CGFloat = ((parallaxCollectionView.contentOffset.y - cell.frame.origin.y) / self.IMAGE_HEIGHT) * self.IMAGE_OFFSET_SPEED
                cell.imageOffset = CGPointMake(0, yOffset)

            }
            
        }
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
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

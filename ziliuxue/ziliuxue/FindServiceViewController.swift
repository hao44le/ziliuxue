//
//  FindServiceViewController.swift
//  
//
//  Created by Gelei Chen on 7/22/15.
//
//

import UIKit

class FindServiceViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var parallaxCollectionView: UICollectionView!
    let name = ["简历写作","论文写作","推荐信写作","个人声明","提交申请","签证代理","机票代理","国外租房","国外接机"]
    let image = ["resume","essay","recommendation_letter","personal_statement","application_form","visa","airplane_ticket","room_rental","airport"]
    
    var selectedServiceName = ""
    
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
        //cell.textLabel.layer.borderColor = UIColor.blackColor().CGColor
        //cell.textLabel.layer.borderWidth = 3
        //cell.textLabel.layer.cornerRadius = 10
        let yOffset = ((collectionView.contentOffset.y - cell.frame.origin.y) / self.IMAGE_HEIGHT) * self.IMAGE_OFFSET_SPEED
        cell.imageOffset = CGPointMake(0, yOffset)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
        
        self.selectedServiceName = self.name[indexPath.row] as String
        
        //self.performSegueWithIdentifier("toCourse", sender: self)
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

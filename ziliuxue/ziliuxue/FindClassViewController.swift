//
//  FindClassViewController.swift
//  
//
//  Created by Gelei Chen on 7/7/15.
//
//

import UIKit

class FindClassViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    let name = ["TOEFL","IELTS","GRE","GMAT","LSAT"]
    let imageName = ["1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = MPSkewedParallaxLayout()
        layout.lineSpacing = 3
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 350)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(MPSkewedCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
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
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
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
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MPSkewedCell
        cell.image = UIImage(named: imageName[indexPath.row])
        cell.text = name[indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
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

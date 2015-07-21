//
//  ThridWizardViewController.swift
//  
//
//  Created by Gelei Chen on 6/23/15.
//
//

import UIKit

class ThridWizardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdPicture: UIImageView!
    @IBOutlet weak var secondPicture: UIImageView!
    @IBOutlet weak var firstPicture: UIImageView!
    
   
    
    @IBAction func finishButtonClicked(sender: UIButton) {
        Tool.showProgressHUD("正在上传资料")
        let defaults = NSUserDefaults.standardUserDefaults()
        let country = defaults.objectForKey("userDestinationCountry") as! String
        let degree = defaults.objectForKey("userTargetedDegree") as! String
        let major = defaults.objectForKey("userSpecificMajor") as! String
        let gpa = defaults.objectForKey("userGPA") as! String
        let toefl = defaults.objectForKey("userTOEFL") as! String
        let sat = defaults.objectForKey("userSAT") as! String
        var schools : [String] = []
        if let firstUniversity = defaults.objectForKey("firstUniversity") as? String {
            if let secondUniversity = defaults.objectForKey("secondUniversity") as? String {
                if let thirdUniversity = defaults.objectForKey("thirdUniversity") as? String {
                    schools = [firstUniversity,secondUniversity,thirdUniversity]
                } else {
                    schools = [firstUniversity,secondUniversity]
                }
            } else {
                schools = [firstUniversity]
            }
        }
        ServerMethods.createUserProfile(country, degree: degree, major: major, gpa: gpa.floatValue, toefl: toefl.floatValue, sat: sat.floatValue, my_schools: schools)
        
    }
    
    var localFilteredUniversityArray : [College] = []
    var serverFilteredUniversityArray : [College] = []
    var resultSeachController = UISearchController()
    var selectedUniversity = ""
    var currentPage = 1
    var maxPages = 600
    var universityArray : [College] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("College", ofType: "plist")
        
        
        let fileManager = NSFileManager.defaultManager()
        let data : NSArray = NSArray(contentsOfFile: path!)!
        for school in data {
            let id = school.objectForKey("_id") as! String
            let name = school.objectForKey("name") as! String
            let general = school.objectForKey("general") as! NSDictionary
            
            
            let website = general.objectForKey("website") as! String
            let logo = name + " logo"
            
            let address = general.objectForKey("address") as! NSDictionary
            let photos = [name + " photo1",name + " photo2",name + " photo3"]
            
            let city = address.objectForKey("city") as! String
            let country = address.objectForKey("country") as! String
            let state = address.objectForKey("state") as! String
            let zipcode = address.objectForKey("zipcode") as! String
            
            let college = College(id: id, name: name, city: city, state: state, country: country, zipcode: zipcode, website: website, logo: logo, photos: photos)
            universityArray.append(college)
        }
        
        self.firstPicture.image = UIImage(named: "defaultWizard1")
        self.firstPicture.layer.cornerRadius = 32
        self.firstPicture.clipsToBounds = true
        self.firstPicture.layer.borderWidth = 2
        self.firstPicture.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        
        
        self.secondPicture.image = UIImage(named: "defaultWizard2")
        self.secondPicture.layer.cornerRadius = 32
        self.secondPicture.clipsToBounds = true
        self.secondPicture.layer.borderWidth = 2
        self.secondPicture.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        
        self.thirdPicture.image = UIImage(named: "defaultWizard3")
        self.thirdPicture.layer.cornerRadius = 32
        self.thirdPicture.clipsToBounds = true
        self.thirdPicture.layer.borderWidth = 2
        self.thirdPicture.layer.borderColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 1).CGColor
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "addTopPicture", name: "addTopPicture", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeTopPicture", name: "removeTopPicture", object: nil)
        
        
        let defaults = NSNotificationCenter.defaultCenter()
        defaults.addObserver(self, selector: "getCollegeSuccessed:", name: "getCollegeSuccessed", object: nil)
        defaults.addObserver(self, selector: "getCollegeFailed", name: "getCollegeFailed", object: nil)
        defaults.addObserver(self, selector: "createUserProfileSuccessed", name: "createUserProfileSuccessed", object: nil)
        defaults.addObserver(self, selector: "createUserProfileFailed", name: "createUserProfileFailed", object: nil)
        
        defaults.addObserver(self, selector: "deleteFirstUniversityAndMoveSecondDown", name: "deleteFirstUniversityAndMoveSecondDown", object: nil)
        defaults.addObserver(self, selector: "addCurrentUniversityToThirdUniversity", name: "addCurrentUniversityToThirdUniversity", object: nil)
        defaults.addObserver(self, selector: "addCurrentUniversityToSecondUniversity", name: "addCurrentUniversityToSecondUniversity", object: nil)
        defaults.addObserver(self, selector: "addCurrentUniversityToFirstUniversity", name: "addCurrentUniversityToFirstUniversity", object: nil)
        defaults.addObserver(self, selector: "deleteFirstUniversityAndMoveOthersDown", name: "deleteFirstUniversityAndMoveOthersDown", object: nil)
        defaults.addObserver(self, selector: "deleteFirstUniversity", name: "deleteFirstUniversity", object: nil)
        defaults.addObserver(self, selector: "deleteSecondUniversityAndMoveThirdUniversityDown", name: "deleteSecondUniversityAndMoveThirdUniversityDown", object: nil)
        defaults.addObserver(self, selector: "deleteSecondUniversity", name: "deleteSecondUniversity", object: nil)
        defaults.addObserver(self, selector: "deleteThirdUniversity", name: "deleteThirdUniversity", object: nil)
        
        self.resultSeachController = ({
            //let searchResultsController : UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("TableSearchResultsNavController") as! UINavigationController
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            //controller.delegate = self
            controller.searchBar.sizeToFit()
            controller.searchBar.barTintColor = UIColor.whiteColor()
            controller.searchBar.searchBarStyle = UISearchBarStyle.Minimal
            controller.searchBar.tintColor = UIColor.blackColor()
            controller.searchBar.placeholder = "搜索大学专业"
            controller.searchBar.translucent = false
            //controller.searchBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
            controller.searchBar.delegate = self
            controller.hidesNavigationBarDuringPresentation = false
            //self.view.addSubview(controller.searchBar)
            
            //controller.searchBar.frame = CGRectMake(0, 64, ScreenSize.SCREEN_WIDTH, 44)
            //self.view.addSubview(controller.searchBar)
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()


        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "学校", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        doneButton.layer.cornerRadius = 25
        doneButton.layer.borderWidth = 0.5
        doneButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        /*
        if DeviceType.IS_IPHONE_6 {
            self.tableViewHeightConstraint.constant = 500
        } else if DeviceType.IS_IPHONE_5 {
            
        } else if DeviceType.IS_IPHONE_6P {
            
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            
        } else if DeviceType.IS_IPAD {
            
        }
*/
        
        // Do any additional setup after loading the view.
    }
    func getCollegeFailed(){
        
    }
    func getCollegeSuccessed(notification:NSNotification){
        let college = notification.object as! [College]
        
    }
    
    func loadUniversities(page:Int) {
        let end = page * 20
        let begin = end - 19
        //ServerMethods.getCollege(begin.description, to: end.description)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.resultSeachController.searchBar.text == "" {
            self.resultSeachController.searchBar.resignFirstResponder()
            self.resultSeachController.active = false
        }
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.resultSeachController.active{
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == (self.universityArray.count - 1) ) && (self.currentPage != self.maxPages) {
            self.loadUniversities(++self.currentPage)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if self.resultSeachController.active {
            if section == 0 {
                return self.localFilteredUniversityArray.count
            } else {
                return self.serverFilteredUniversityArray.count
            }
        } else {
            if self.currentPage == self.maxPages {
                return self.universityArray.count
            } else {
                return self.universityArray.count + 1
            }
            
        }
        //return 0
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.resultSeachController.active {
            if section == 0 {
                if self.localFilteredUniversityArray.count != 0 {
                    return "最近搜索"
                }
                
            } else {
                if self.serverFilteredUniversityArray.count != 0 {
                    return "更多学校"
                }
            }
        } else {
            return ""
        }
        return ""
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == self.universityArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath) as! UITableViewCell
            let activityIndicator = cell.contentView.viewWithTag(100) as! UIActivityIndicatorView
            activityIndicator.startAnimating()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ThirdWizardTableViewCell
            cell.logo.layer.cornerRadius = 30
            cell.logo.clipsToBounds = true
            //cell.logo.layer.borderWidth = 1
            
            if resultSeachController.active {
                if indexPath.section == 0 {
                    //local result
                    cell.universityName.text = self.localFilteredUniversityArray[indexPath.row].name
                    cell.logo.image = UIImage(named: self.localFilteredUniversityArray[indexPath.row].logo)
                } else {
                    //server result
                    cell.universityName.text = self.serverFilteredUniversityArray[indexPath.row].name
                    cell.logo.image = UIImage(named: self.serverFilteredUniversityArray[indexPath.row].logo)
                }
                
            } else {
                //println(self.universityArray[indexPath.row].name)
                //println(self.universityArray[indexPath.row].logo)
                cell.universityName.text = self.universityArray[indexPath.row].name
                cell.logo.image = UIImage(named: self.universityArray[indexPath.row].logo)
            }
            
            if let first = NSUserDefaults.standardUserDefaults().objectForKey("firstUniversity") as? String {
                if first == cell.universityName.text {
                    cell.like.setImage(UIImage(named: "star_filled"), forState: UIControlState.Normal)
                    return cell
                }
            }
            if let second = NSUserDefaults.standardUserDefaults().objectForKey("secondUniversity") as? String {
                if second == cell.universityName.text {
                    cell.like.setImage(UIImage(named: "star_filled"), forState: UIControlState.Normal)
                    return cell
                }
            }
            
            if let third = NSUserDefaults.standardUserDefaults().objectForKey("thirdUniversity") as? String {
                if third == cell.universityName.text {
                    cell.like.setImage(UIImage(named: "star_filled"), forState: UIControlState.Normal)
                    return cell
                }
            }
            
            cell.like.setImage(UIImage(named: "star"), forState: UIControlState.Normal)
            return cell
        }
        
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toUniversityDetail", sender: self)
        
    }
    
    /*
    
    func addTopPicture(){
        //print("add function")
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name: AnyObject = defaults.objectForKey("currentCelectedSchool") {
            let number = defaults.integerForKey("numberOfFavoritedSchool")
            //print(name)
            //print(number)
            switch number {
            case 1:
                UIView.animateWithDuration(0.85, animations: { () -> Void in
                    self.firstPicture.image = UIImage(named: name as! String)

                })
            case 2:
                UIView.animateWithDuration(0.85, animations: { () -> Void in
                    self.secondPicture.image = UIImage(named: name as! String)
                    
                })
                
            case 3:
                UIView.animateWithDuration(0.85, animations: { () -> Void in
                    self.thirdPicture.image = UIImage(named: name as! String)
                    
                })
            default:
                break
            }
        }
    }
    
    
    func removeTopPicture(){
        //print("remove function")
        let defaults = NSUserDefaults.standardUserDefaults()
        let number = defaults.integerForKey("numberOfFavoritedSchool")
        //print(number)
        switch number {
        case 1:
            UIView.animateWithDuration(0.85, animations: { () -> Void in
                self.firstPicture.image = UIImage(named: "Map Icon")
                
            })
        case 2:
            UIView.animateWithDuration(0.85, animations: { () -> Void in
                self.secondPicture.image = UIImage(named: "Map Icon")
                
            })
            
        case 3:
            UIView.animateWithDuration(0.85, animations: { () -> Void in
                self.thirdPicture.image = UIImage(named: "Map Icon")
                
            })
        default:
            break
        }

    }
    
    */
    
    
    func addCurrentUniversityToThirdUniversity(){
        //获得用户当前选择学校
        if let third = NSUserDefaults.standardUserDefaults().objectForKey("thirdUniversity") as? String {
            //更新图片
            self.thirdPicture.image = UIImage(named: third)
        }
        
    }
    
    func addCurrentUniversityToSecondUniversity(){
        //获得用户当前选择学校
        if let second = NSUserDefaults.standardUserDefaults().objectForKey("secondUniversity") as? String {
            //更新图片
            self.secondPicture.image = UIImage(named: second)
        }
        
    }
    func addCurrentUniversityToFirstUniversity(){
        //获得用户当前选择学校
        if let first = NSUserDefaults.standardUserDefaults().objectForKey("firstUniversity") as? String {
            //更新图片
            self.firstPicture.image = UIImage(named: first)
        }
        
    }
    func deleteFirstUniversityAndMoveSecondDown(){
        if let firstUniversity = NSUserDefaults.standardUserDefaults().objectForKey("firstUniversity") as? String {
            self.firstPicture.image = UIImage(named: firstUniversity)
            self.deleteSecondUniversity()
        }
        
    }
    
    
    func deleteFirstUniversityAndMoveOthersDown(){
        if let firstUniversity = NSUserDefaults.standardUserDefaults().objectForKey("firstUniversity") as? String {
            if let secondUniversity = NSUserDefaults.standardUserDefaults().objectForKey("secondUniversity") as? String {
                self.firstPicture.image = UIImage(named: firstUniversity)
                self.secondPicture.image = UIImage(named: secondUniversity)
                self.deleteThirdUniversity()
            }
        }
        
    }
    func deleteFirstUniversity(){
        //删除图片
        self.firstPicture.image = UIImage(named: "defaultWizard1")
        
    }
    func deleteSecondUniversityAndMoveThirdUniversityDown(){
        if let secondUniversity = NSUserDefaults.standardUserDefaults().objectForKey("secondUniversity") as? String {
            self.secondPicture.image = UIImage(named: secondUniversity)
            self.deleteThirdUniversity()
        }
        
    }
    func deleteSecondUniversity(){
        //删除图片
        self.secondPicture.image = UIImage(named: "defaultWizard2")
    }
    
    func deleteThirdUniversity(){
        //删除图片
        self.thirdPicture.image = UIImage(named: "defaultWizard3")
    }

    func getSearchResultsFromServer(keyword:String){
        
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        localFilteredUniversityArray.removeAll(keepCapacity: false)
        serverFilteredUniversityArray.removeAll(keepCapacity: false)
        if self.resultSeachController.searchBar.text == "" {
            self.localFilteredUniversityArray = self.universityArray
        } else {
            //Local search
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (universityArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.localFilteredUniversityArray = array as! [College]
            
            //sever search
            getSearchResultsFromServer(searchController.searchBar.text)
        }
        
        
        
        self.tableView.reloadData()
        
    }

    
    func createUserProfileSuccessed(){
        Tool.dismissHUD()
        self.performSegueWithIdentifier("finishWizard", sender: self)
    }
    func createUserProfileFailed(){
        Tool.dismissHUD()
        Tool.showErrorHUD("建立用户资料失败，请重试")
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "finishWizard" {
            
        }
    }
    

}

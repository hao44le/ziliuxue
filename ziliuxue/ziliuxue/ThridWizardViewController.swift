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
    
   
    
    
    var localFilteredUniversityArray : [String] = []
    var resultSeachController = UISearchController()
    var selectedUniversity = ""
    
    var universityName = ["7","12","15","Harvard University","Stanford University"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "addTopPicture", name: "addTopPicture", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeTopPicture", name: "removeTopPicture", object: nil)
        
        
        self.resultSeachController = ({
            //let searchResultsController : UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("TableSearchResultsNavController") as! UINavigationController
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            //controller.delegate = self
            controller.searchBar.sizeToFit()
            controller.searchBar.barTintColor = UIColor(red: 162/255, green: 49/255, blue: 59/255, alpha: 0.8)
            controller.searchBar.tintColor = UIColor.whiteColor()
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
        
        
        if DeviceType.IS_IPHONE_6 {
            self.tableViewHeightConstraint.constant = 500
        } else if DeviceType.IS_IPHONE_5 {
            
        } else if DeviceType.IS_IPHONE_6P {
            
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            
        } else if DeviceType.IS_IPAD {
            
        }
        // Do any additional setup after loading the view.
    }
    


    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.resultSeachController.searchBar.text == "" {
            self.resultSeachController.searchBar.resignFirstResponder()
            self.resultSeachController.active = false
        }
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSeachController.active {
            return self.localFilteredUniversityArray.count
        } else {
            return self.universityName.count
        }
        
        
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ThirdWizardTableViewCell
        if resultSeachController.active {
            cell.universityName.text = self.localFilteredUniversityArray[indexPath.row]
            cell.logo.image = UIImage(named: self.localFilteredUniversityArray[indexPath.row])
        } else {
            cell.universityName.text = self.universityName[indexPath.row]
            cell.logo.image = UIImage(named: self.universityName[indexPath.row])
        }
        
        
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("toUniversityDetail", sender: self)
        
    }
    
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        localFilteredUniversityArray.removeAll(keepCapacity: false)
        
        if self.resultSeachController.searchBar.text == "" {
            self.localFilteredUniversityArray = self.universityName
        } else {
            //Local search
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (universityName as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.localFilteredUniversityArray = array as! [String]
            
            
        }
        
        
        
        self.tableView.reloadData()
        
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

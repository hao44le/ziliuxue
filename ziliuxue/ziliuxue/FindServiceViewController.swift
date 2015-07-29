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
        self.parallaxCollectionView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
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
        
        self.performSegueWithIdentifier("toService", sender: self)
        
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
   
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toService" {
            let vc = segue.destinationViewController as! ServiceOverviewViewController
            vc.topName = "找" + self.selectedServiceName + "服务"
            
            switch self.selectedServiceName {
            case name[0] :
                vc.teacherName = ["    Stephenie An","    Alex Song","    Julia Chen","    王小米","    黄大卫","    张佳丽","    Ken Wang","    Sara Qiao"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["1","2","3","4","5","6","7","8"]
            case name[1] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["9","10","11","12","13","14","15","16"]
            case name[2] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["17","18","19","20","21","22","23","24"]
            case name[3] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["25","26","27","28","29","30","1","2"]
            case name[4] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["3","4","5","6","7","8","9","10"]
            case name[5] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["9","10","11","12","13","14","15","16"]
            case name[6] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["17","18","19","20","21","22","23","24"]
            case name[7] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["25","26","27","28","29","30","1","2"]
            case name[8] :
                vc.teacherName = ["    Sherry Fang","    Emily Chang","    Julia Chen","    王小兰","    Nancy Jiang","    张佳丽","    Jun Wang","    Amanda Chen"]
                vc.titleName = ["计算机高级简历","计算机电子工程高级个人声明，论文写手","社会人文心理科高级个人声明，推荐信写手","推荐信，简历高级写手","法律类高级个人声明，简历写手","化学，物化高级论文写手","化学，计算机个人声明，简历高级写手","MBA类个人声明，论文，简历高级写手"]
                vc.detail = ["计算机，电子工程，信息系统工程","计算机，人工智能，电子工程 | 北美高校","社会，人文，心理 | 北美高校","文理各科推荐信，简历","法律类个人声明，简历，推荐信","化学类，物理化学类论文，个人声明，推荐信","化学，计算机，化工个人声明，简历","MBA类个人声明，论文，简历，推荐信"]
                vc.like = ["12,568","9,268","8,973","7,835","11,763","9,268","8,973","7,835"]
                vc.teacherImage = ["3","4","5","6","7","8","9","10"]
            default:
                break
            }
        }
    }
    

}

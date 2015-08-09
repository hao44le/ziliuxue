//
//  LandingPageDetailViewController.swift
//  
//
//  Created by Gelei Chen on 8/3/15.
//
//

import UIKit
import MediaPlayer
import AVFoundation
import MapKit
import CoreLocation

class LandingPageDetailViewController: UIViewController,CLLocationManagerDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    
    @IBOutlet weak var firstViewHeight: NSLayoutConstraint!
    @IBOutlet weak var secondViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var thirdViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var fourthViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var fifthViewHeight: NSLayoutConstraint!
    var secondHeightVariable : CGFloat = 356
    var thirdHeightVariable : CGFloat = 356
    var fourthHeightVariable : CGFloat = 356
    var fifthViewHeightVariable : CGFloat = 356
    
    var scrollViewHeight : CGFloat = 2000
    
    var moviePlayer : MPMoviePlayerController?
    var topName = ""
    var names :[String]?
    let locationManager = CLLocationManager()
    var location:CLLocationCoordinate2D?
    var mapView: MKMapView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = self.topName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse{
            self.locationManager.requestWhenInUseAuthorization()
            
        } else {
            locationManager.startUpdatingLocation()
        }
        self.view.backgroundColor = UIColor.whiteColor()
       self.navigationController?.navigationBar.topItem?.title = ""
        switch names!.count {
        case 1:
             self.firstLabel.text = names![0]
        case 2:
            self.secondLabel.text = names![1]
        case 3:
            self.thirdLabel.text = names![2]
        case 4:
            self.fourthLabel.text = names![3]
        default:
            break
        }
        for name in names! {
            
        }
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 50))
        setUpVideo()
        
        
        
        // Do any additional setup after loading the view.
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.secondViewHeight.constant = secondHeightVariable
        self.thirdViewHeight.constant = thirdHeightVariable
        self.fourthViewHeight.constant = fourthHeightVariable
        self.fifthViewHeight.constant = fifthViewHeightVariable
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //println(self.scrollView.frame)
        //println(self.firstView.frame)
        self.scrollView.contentSize.height = scrollViewHeight
    }
    /*
    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
       
    }
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        return UIInterfaceOrientation.Portrait
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo(){
        self.moviePlayer!.prepareToPlay()
        self.moviePlayer!.play()
        self.moviePlayer!.setFullscreen(true, animated: true)
    }
    
    func setUpVideo(){
        
        if let url = NSURL(string: "http://krtv.qiniudn.com/150522nextapp"), moviePlayer = MPMoviePlayerController(contentURL: url){
            self.moviePlayer = moviePlayer
            moviePlayer.view.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 200)
            //moviePlayer.movieSourceType = MPMovieSourceType.Streaming
           // moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
            //moviePlayer.fullscreen = true
            moviePlayer.scalingMode = MPMovieScalingMode.AspectFit
            
            self.scrollView.addSubview(moviePlayer.view)
            loadImage(url)
            setupButton()
            //self.view.bringSubviewToFront(moviePlayer.view)
        } else {
            debugPrintln("something wrong")
        }
    }

   
    
    
    func loadImage(url:NSURL){
        let imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 200)
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.alpha = 0.9
        
        imageView.image = UIImage(named: "classroom")
        
        self.scrollView.addSubview(imageView)
        
        /*
        let asset = AVURLAsset(URL: url, options: nil)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMake(1, 2)
        let imgRef = generator.copyCGImageAtTime(time, actualTime: nil, error: nil)
        let thumbnail = UIImage(CGImage: imgRef)
        self.imageView.frame = CGRectMake(0, 60, ScreenSize.SCREEN_WIDTH, 200)
        self.imageView.clipsToBounds = true
        self.imageView.image = thumbnail
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.alpha = 0.9
        self.view.addSubview(self.imageView)
        */
    
        
    }
    
    
    func setupButton(){
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.addTarget(self, action: "playVideo", forControlEvents: UIControlEvents.TouchUpInside)
        //button!.backgroundColor = UIColor.clearColor()
        button.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 200)
        
        button.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        self.scrollView.addSubview(button)
    }
    
    func getDataFromServer() -> Void {
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let currentLocation = locations {
            
            if location == nil {
                getDataFromServer()
                //self.tableView.reloadData()
            }
            let thisLocation : CLLocation = currentLocation[0] as! CLLocation
            location = thisLocation.coordinate
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

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

class LandingPageDetailViewController: UIViewController,MKMapViewDelegate,UIScrollViewDelegate,UITableViewDataSource{
    
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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var introducationLabel: UILabel!
    
    @IBOutlet weak var firstTopicLabel: UILabel!
    @IBOutlet weak var secondTopicLabel: UILabel!
    
    @IBOutlet weak var thirdTopicLabel: UILabel!
    
    
    
    var titleLabelContent = ""
    var timeLabelContent = "2016.1.12 10.38"
    var introducationLabelContent = "西洋的王博士重点谈谈各国留学的优势和适合的人群。他曾留学澳洲。转学新西兰，最后到美国就业，多次参与各国留学的评论。他的经验非常值得借鉴。                                                            "
    var firstTopicLabelContent = "1"
    var secondTopicLabelContent = "2"
    var thirdTopicLabelContent = "3"

    var viewWhichHoldsMap = 2
    var viewWhichHoldsTableView = 3
    
    var secondHeightVariable : CGFloat = 356
    var thirdHeightVariable : CGFloat = 356
    var fourthHeightVariable : CGFloat = 356
    var fifthViewHeightVariable : CGFloat = 356
    
    var scrollViewHeight : CGFloat = 2000
    
    var moviePlayer : MPMoviePlayerController?
    var topName = ""
    //var names :[String]?
    let locationManager = CLLocationManager()
    var location:CLLocationCoordinate2D?
    var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 10000
    var geo_location : NSDictionary = ["longitude":"-157.829444","latitude":"21.282778","title":"test"]
    let imageView = UIImageView()
    let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    var readyToPlay = false
    var moviewPlayerOriginFrame : CGRect?
    var tableView : UITableView = UITableView()
    var tableViewLeft : [String] = []
    var tableViewRight : [String] = []
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = self.topName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playbackStateChanged", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: nil)
        self.scrollView.delegate = self
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse{
            self.locationManager.requestWhenInUseAuthorization()
            
        }
        setUpView()
        
        /*
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
        */
        
        //let imageView = UIImageView(frame: CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 50))
        
        
        
        // Do any additional setup after loading the view.
    }
    func playbackStateChanged(){
        //println(self.moviePlayer!.playbackState.rawValue)
        if self.moviePlayer!.playbackState.rawValue == 2 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.moviePlayer!.view.frame = self.moviewPlayerOriginFrame!
                self.scrollView.sendSubviewToBack(self.moviePlayer!.view)
            })
            
        }
    }
    
    func setUpView(){
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.titleLabel.text = titleLabelContent
        self.timeLabel.text = timeLabelContent
        self.introducationLabel.text = introducationLabelContent
        self.firstTopicLabel.text = firstTopicLabelContent
        self.secondTopicLabel.text = secondTopicLabelContent
        self.thirdTopicLabel.text = thirdTopicLabelContent
        self.firstTopicLabel.sizeToFit()
        self.secondTopicLabel.sizeToFit()
        self.thirdTopicLabel.sizeToFit()
        self.firstLabel.text = firstTopicLabelContent
        self.secondLabel.text = secondTopicLabelContent
        self.thirdLabel.text = thirdTopicLabelContent
        self.firstLabel.sizeToFit()
        self.secondLabel.sizeToFit()
        self.thirdLabel.sizeToFit()
        switch viewWhichHoldsMap {
        case 2:
            setupMapView(self.secondView)
        case 3:
            setupMapView(self.thirdView)
        case 4:
            setupMapView(self.fourthView)
        case 5:
            setupMapView(self.fifthView)
        default :
            break
        }
        setUpVideo()
        switch viewWhichHoldsTableView {
        case 2:
            setUpTableView(self.secondView)
        case 3:
            setUpTableView(self.thirdView)
        case 4:
            setUpTableView(self.fourthView)
        case 5:
            setUpTableView(self.fifthView)
        default :
            break
        }
        
        //更新托福分数
        let label = UILabel(frame: CGRectMake(0, 10, ScreenSize.SCREEN_WIDTH, 100))
        label.text = "请更新您的托福分数，以便获得更精准的学校推荐"
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(13)
        self.fourthView.addSubview(label)
        
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.frame = CGRectMake((ScreenSize.SCREEN_WIDTH - 100) / 2, 110, 100, 50)
        
        //button.backgroundColor = UIColor.blueColor()
        //button.tintColor = Utils.mainColor
        button.setTitle("更新分数", forState: UIControlState.Normal)
        button.setTitleColor(Utils.mainColor, forState: UIControlState.Normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = Utils.mainColor.CGColor
        button.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        //button.userInteractionEnabled = true
        self.fourthView.addSubview(button)
        
        self.fifthView.hidden = true
        self.scrollViewHeight -= self.fifthView.frame.height
        
    }
    
    func buttonTouched(){
        println("更新分数")
    }
    
    func setUpTableView(whichView:UIView){
        self.tableView.frame = CGRectMake(0, 30, ScreenSize.SCREEN_WIDTH, 300)
        //self.tableView.registerClass(UITableViewCell(), forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        //self.tableViewRight = ["1","2"]
        //self.tableViewLeft = ["4","5"]
        self.tableView.rowHeight = 40
        self.tableView.allowsSelection = false
        self.tableView.scrollEnabled = false
        //self.tableView.registerClass(UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell").classForCoder, forCellReuseIdentifier: "cell")
        whichView.addSubview(self.tableView)
        self.tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewLeft.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: CellIdentifier)
        }
        
        cell!.textLabel!.text = self.tableViewLeft[indexPath.row]
        cell!.detailTextLabel?.text = self.tableViewRight[indexPath.row]
        return cell!
    }
    
    func setupMapView(whichView:UIView){
        mapView = MKMapView(frame: CGRectMake(0, 30, ScreenSize.SCREEN_WIDTH, 300))
        
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        loadInitialData()
        centerMapOnLocation(initialLocation)
        whichView.addSubview(mapView)
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
        self.imageView.hidden = true
        self.button.hidden = true
        self.readyToPlay = true
        //self.view.bringSubviewToFront(moviePlayer!.view)
        //self.moviePlayer!.setFullscreen(true, animated: true)
    }
    
    
    func setUpVideo(){
        
        if let url = NSURL(string: "http://livebo.cloudapp.net:8080/hls/sl.m3u8"), moviePlayer = MPMoviePlayerController(contentURL: url){
            self.moviePlayer = moviePlayer
            moviePlayer.view.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 200)
            self.moviewPlayerOriginFrame = moviePlayer.view.frame
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
        
        button.addTarget(self, action: "playVideo", forControlEvents: UIControlEvents.TouchUpInside)
        //button!.backgroundColor = UIColor.clearColor()
        button.frame = CGRectMake(0, 0, ScreenSize.SCREEN_WIDTH, 200)
        
        button.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        self.scrollView.addSubview(button)
    }
    
    func loadInitialData() {
        let location = CLLocationCoordinate2DMake((geo_location.objectForKey("latitude") as! NSString).doubleValue, (geo_location.objectForKey("longitude") as! NSString).doubleValue)
        let annotation = CourseAnnotation(coordinate: location, title: geo_location.objectForKey("title") as! String, subtitle: "", image:UIImage(named: "coursePin")!)
        self.mapView.addAnnotation(annotation)
    }

    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if annotation.isKindOfClass(CourseAnnotation.classForCoder())
            {
                var identifier = "annotation"
                var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                
                if annotationView == nil{
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView.canShowCallout=true;
                    annotationView.calloutOffset=CGPointMake(0, 0);
                    annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "coursePin"))
                    
                }
                
                annotationView.annotation = annotation
                annotationView.image = (annotation as! CourseAnnotation).image
                
                return annotationView
            }
            else{
                return nil
            }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.readyToPlay && self.moviePlayer!.playbackState.rawValue == 1{
            //print("1")
            let frame = self.moviePlayer!.view.frame
            
            
            
            //self.moviePlayer!.view.removeFromSuperview()
            
            let newFrame = CGRectMake(0, scrollView.contentOffset.y, frame.width, frame.height)
            self.moviePlayer!.view.frame = newFrame
            
            //if firstTimeScroll {
                //firstTimeScroll = false
                //self.moviePlayer!.view.removeFromSuperview()
                //self.view.addSubview(moviePlayer!.view)
                //let scrollViewNewFrame = CGRectMake(0, frame.height, frame.width, self.scrollView.frame.height)
                //self.scrollView.frame = scrollViewNewFrame
            //}
            
            
            //self.view.addSubview(self.moviePlayer!.view)
            //UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.moviePlayer!.view)
            //self.view.layer.zPosition = 1
            //self.view.bringSubviewToFront(self.moviePlayer!.view)
            self.scrollView.bringSubviewToFront(self.moviePlayer!.view)
            
            
            
            
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

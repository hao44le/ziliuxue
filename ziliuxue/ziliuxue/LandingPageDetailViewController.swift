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

class LandingPageDetailViewController: UIViewController {
    
    let imageView = UIImageView()
    var moviePlayer : MPMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.view.backgroundColor = UIColor.whiteColor()
        setUpVideo("456")
        
        
        
        
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.addTarget(self, action: "playVideo", forControlEvents: UIControlEvents.TouchUpInside)
        //button.backgroundColor = UIColor.whiteColor()
        button.frame = self.imageView.frame
        
        button.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        self.view.addSubview(button)
        
        // Do any additional setup after loading the view.
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
    
    func setUpVideo(name:String){
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "mp4"), url = NSURL(fileURLWithPath: path), moviePlayer = MPMoviePlayerController(contentURL: url){
            self.moviePlayer = moviePlayer
            moviePlayer.view.frame = CGRectMake(0, 60, ScreenSize.SCREEN_WIDTH, 200)
           // moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
            //moviePlayer.fullscreen = true
            moviePlayer.scalingMode = .AspectFill
            
            self.view.addSubview(moviePlayer.view)
            loadImage(url)
            //self.view.bringSubviewToFront(moviePlayer.view)
        } else {
            debugPrintln("something wrong")
        }
    }
    
    func loadImage(url:NSURL){
        let asset = AVURLAsset(URL: url, options: nil)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMake(1, 1)
        let imgRef = generator.copyCGImageAtTime(time, actualTime: nil, error: nil)
        let thumbnail = UIImage(CGImage: imgRef)
        self.imageView.frame = CGRectMake(0, 60, ScreenSize.SCREEN_WIDTH, 200)
        self.imageView.clipsToBounds = true
        self.imageView.image = thumbnail
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.alpha = 0.9
        self.view.addSubview(self.imageView)
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

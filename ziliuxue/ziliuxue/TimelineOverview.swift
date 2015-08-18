//
//  TimelineOverview.swift
//  ziliuxue
//
//  Created by Gelei Chen on 16/8/15.
//  Copyright (c) 2015 ziliuxue. All rights reserved.
//


import UIKit
import AVFoundation

/**
Represents an instance in the Timeline. A Timeline is built using one or more of these TimeOverviewFrames.
*/
public struct TimeOverviewFrame{
    /**
    A description of the event.
    */
    let section : [TimelineOverviewSection]
    let image: UIImage?
}

public struct TimelineOverviewSection{
    /**
    A description of the event.
    */
    let detail: String
    /**
    The date that the event occured.
    */
    let title: String
    
    let time : String
}


/**
View that shows the given events in bullet form.
*/
public class TimelineOverview: UIView {
    
    //MARK: Public Properties
    
    /**
    The events shown in the Timeline
    */
    public var TimeOverviewFrames: [TimeOverviewFrame]{
        didSet{
            setupContent()
        }
    }
    
    /**
    The color of the bullets and the lines connecting them.
    */
    public var lineColor: UIColor = UIColor.lightGrayColor(){
        didSet{
            setupContent()
        }
    }
    
    /**
    Color of the larger Date title label in each event.
    */
    public var titleLabelColor: UIColor = Utils.mainColor{
        didSet{
            setupContent()
        }
    }
    
    /**
    Color of the smaller Text detail label in each event.
    */
    public var detailLabelColor: UIColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1){
        didSet{
            setupContent()
        }
    }
    
    /**
    The type of bullet shown next to each element.
    */
    public var bulletType: BulletType = BulletType.Diamond{
        didSet{
            setupContent()
        }
    }
    
    //MARK: Private Properties
    
    //private var imageViewer: JTSImageViewController?
    
    //MARK: Public Methods
    
    /**
    Note that the TimeOverviewFrames cannot be set by this method. Further setup is required once this initalization occurs.
    
    May require more work to allow this to work with restoration.
    
    @param coder An unarchiver object.
    */
    required public init(coder aDecoder: NSCoder) {
        TimeOverviewFrames = []
        super.init(coder: aDecoder)
    }
    
    /**
    Initializes the timeline with all information needed for a complete setup.
    
    @param bulletType The type of bullet shown next to each element.
    
    @param TimeOverviewFrames The events shown in the Timeline
    */
    public init(bulletType: BulletType, TimeOverviewFrames: [TimeOverviewFrame]){
        self.TimeOverviewFrames = TimeOverviewFrames
        self.bulletType = bulletType
        super.init(frame: CGRect.zeroRect)
        
        setTranslatesAutoresizingMaskIntoConstraints(false)
        
        setupContent()
    }
    
    //MARK: Private Methods
    
    private func setupContent(){
        for v in subviews{
            v.removeFromSuperview()
        }
        
        let guideView = UIView()
        guideView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(guideView)
        addConstraints([
            NSLayoutConstraint(item: guideView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 24),
            NSLayoutConstraint(item: guideView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: guideView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: guideView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0)
            ])
        
        var i = 0
        
        var viewFromAbove = guideView
        
        for element in TimeOverviewFrames{
            let v = blockForTimeOverviewFrame(element, imageTag: i)
            addSubview(v)
            addConstraints([
                NSLayoutConstraint(item: v, attribute: .Top, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: v, attribute: .Left, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Width, multiplier: 1.0, constant: 0),
                ])
            viewFromAbove = v
            i++
        }
        
        let extraSpace: CGFloat = 200
        
        let line = UIView()
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = lineColor
        addSubview(line)
        sendSubviewToBack(line)
        addConstraints([
            NSLayoutConstraint(item: line, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 16.5),
            NSLayoutConstraint(item: line, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1),
            NSLayoutConstraint(item: line, attribute: .Top, relatedBy: .Equal, toItem: viewFromAbove, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: extraSpace)
            ])
        addConstraint(NSLayoutConstraint(item: viewFromAbove, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
    }
    
    
    
    private func bulletView(size: CGSize, bulletType: BulletType) -> UIView {
        var path: UIBezierPath
        switch bulletType {
        case .Circle:
            path = UIBezierPath(ovalOfSize: size)
        case .Diamond:
            path = UIBezierPath(diamondOfSize: size)
        case .DiamondSlash:
            path = UIBezierPath(diamondSlashOfSize: size)
        case .Hexagon:
            path = UIBezierPath(hexagonOfSize: size)
        case .Carrot:
            path = UIBezierPath(carrotOfSize: size)
        case .Arrow:
            path = UIBezierPath(arrowOfSize: size)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.path = path.CGPath
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        v.layer.addSublayer(shapeLayer)
        return v
    }
    
    private func blockForTimeOverviewFrame(element: TimeOverviewFrame, imageTag: Int) -> UIView{
        let v = UIView()
        
        v.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //bullet
        let s = CGSize(width: 14, height: 14)
        let bullet: UIView = bulletView(s, bulletType: bulletType)
        v.addSubview(bullet)
        v.addConstraints([
            NSLayoutConstraint(item: bullet, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: bullet, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 0)
            ])
        
        //image
        if let image = element.image{
            
            let backgroundViewForImage = UIView()
            backgroundViewForImage.setTranslatesAutoresizingMaskIntoConstraints(false)
            backgroundViewForImage.backgroundColor = UIColor.blackColor()
            backgroundViewForImage.layer.cornerRadius = 10
            v.addSubview(backgroundViewForImage)
            v.addConstraints([
                NSLayoutConstraint(item: backgroundViewForImage, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -60),
                NSLayoutConstraint(item: backgroundViewForImage, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 130),
                NSLayoutConstraint(item: backgroundViewForImage, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
                NSLayoutConstraint(item: backgroundViewForImage, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 0)
                ])
            
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = 10
            imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            v.addSubview(imageView)
            imageView.tag = imageTag
            v.addConstraints([
                NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: backgroundViewForImage, attribute: .Left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .Right, relatedBy: .Equal, toItem: backgroundViewForImage, attribute: .Right, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: backgroundViewForImage, attribute: .Top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: backgroundViewForImage, attribute: .Bottom, multiplier: 1.0, constant: 0)
                ])
            /*
            let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            button.backgroundColor = UIColor.clearColor()
            button.tag = imageTag
            //button.addTarget(self, action: "tapImage:", forControlEvents: UIControlEvents.TouchUpInside)
            v.addSubview(button)
            v.addConstraints([
                NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -60),
                NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
                NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 0)
                ])
            */
        }
        
        let y = element.image == nil ? 0 as CGFloat : 145.0 as CGFloat
        
        let titleLabel = UILabel()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "ArialMT", size: 20)
        titleLabel.textColor = titleLabelColor
        titleLabel.text = element.section[0].title
        titleLabel.numberOfLines = 0
        titleLabel.layer.masksToBounds = false
        v.addSubview(titleLabel)
        v.addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -40),
            NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: y - 5)
            ])
        
        let timeLabel = UILabel()
        timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        timeLabel.font = UIFont(name: "ArialMT", size: 20)
        timeLabel.textColor = detailLabelColor
        timeLabel.text = element.section[0].time
        timeLabel.numberOfLines = 0
        timeLabel.layer.masksToBounds = false
        timeLabel.textAlignment = NSTextAlignment.Right
        v.addSubview(timeLabel)
        v.addConstraints([
            NSLayoutConstraint(item: timeLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -40),
            NSLayoutConstraint(item: timeLabel, attribute: .Right, relatedBy: .Equal, toItem: v, attribute: .Right, multiplier: 1.0, constant: -10),
            NSLayoutConstraint(item: timeLabel, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: y - 5)
            ])
        
        let detailLabel = UILabel()
        detailLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        detailLabel.font = UIFont(name: "ArialMT", size: 16)
        detailLabel.text = element.section[0].detail
        detailLabel.textColor = detailLabelColor
        detailLabel.numberOfLines = 0
        detailLabel.layer.masksToBounds = false
        v.addSubview(detailLabel)
        v.addConstraints([
            NSLayoutConstraint(item: detailLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -40),
            NSLayoutConstraint(item: detailLabel, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: detailLabel, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: detailLabel, attribute: .Bottom, relatedBy: .Equal, toItem: v, attribute: .Bottom, multiplier: 1.0, constant: -10)
            ])
        
        //draw the line between the bullets
        let line = UIView()
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = lineColor
        v.addSubview(line)
        sendSubviewToBack(line)
        v.addConstraints([
            NSLayoutConstraint(item: line, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1),
            NSLayoutConstraint(item: line, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 16.5),
            NSLayoutConstraint(item: line, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 14),
            NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 1.0, constant: -14)
            ])
        
        //button
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.backgroundColor = UIColor.clearColor()
        button.tag = imageTag
        button.titleLabel?.text = titleLabel.text
        button.tintColor = UIColor.whiteColor()
        //self.currentSelection = titleLabel.text
        button.addTarget(self, action: "tapImage:", forControlEvents: UIControlEvents.TouchUpInside)
        v.addSubview(button)
        v.addConstraints([
            NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -60),
            NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: v, attribute: .Height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 0)
            ])

        
        return v
    }
    func tapImage(button: UIButton){
        //println("tapped")
        
        NSNotificationCenter.defaultCenter().postNotificationName("timelineOverviewButtonTouched", object: nil, userInfo: ["currentSelection":button.titleLabel!.text!])
    }
    /*
    func tapImage(button: UIButton){
    var imageView: UIImageView? = nil
    for v in subviews{
    for w in v.subviews{
				if w.tag == button.tag && w is UIImageView{
    imageView = (w as? UIImageView)
				}
    }
    }
    if let i = imageView, let image = i.image{
    let imageInfo = JTSImageInfo()
    imageInfo.image = i.image
    
    let imageFrame = AVMakeRectWithAspectRatioInsideRect(image.size, i.bounds)
    
    imageInfo.referenceRect = convertRect(imageFrame, fromView: i)
    imageInfo.referenceView = self
    imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.Image, backgroundStyle: JTSImageViewControllerBackgroundOptions.Blurred)
    //imageViewer!.showFromViewController(UIApplication.sharedApplication().keyWindow?.rootViewController, transition: JTSImageViewControllerTransition._FromOriginalPosition)
    imageViewer!.showFromViewController(UIApplication.topViewController(), transition: JTSImageViewControllerTransition._FromOriginalPosition)
    }
    }
    */
}



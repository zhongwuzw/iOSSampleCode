//
//  ZWWatchView.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/25.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable   //Interface Builder 动态展示界面
class ZWWatchView: UIView {
    @IBInspectable var enableClockSecondHand: Bool = false {
        didSet { updateLayerProperties() }
    }
    
    @IBInspectable var enableColorBackground: Bool = false {
        didSet { updateLayerProperties() }
    }
    
    var backgroundLayer:CAShapeLayer!
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.lightGrayColor() { didSet { updateLayerProperties() }
    }
    
    var backgroundImageLayer: CALayer!
    @IBInspectable var backgroundImage: UIImage? {
        didSet  { updateLayerProperties() }
    }
    
    var secondHandLayer: CAShapeLayer!
    @IBInspectable var secondHandColor: UIColor = UIColor.redColor()
    
    var minuteHandLayer: CAShapeLayer!
    @IBInspectable var minuteHandColor: UIColor = UIColor.whiteColor()
    
    var hourHandLayer: CAShapeLayer!
    @IBInspectable var hourHandColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var lineWidth: CGFloat = 1.0
    
    var ringLayer: CAShapeLayer!
    @IBInspectable var ringThickness: CGFloat = 2.0
    @IBInspectable var ringColor: UIColor = UIColor.blueColor()
    @IBInspectable var ringProgress: CGFloat = 45.0/60 {
        didSet { updateLayerProperties() }
    }
    
    var timer = NSTimer()
    var currentTimeZone: String = "Asia/Beijing"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        //Initialize whatever here.
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createClockFace()
    }
    
    func createClockFace() {
        layoutBackgroundLayer()
        layoutBackgroundImageLayer()
        createAnalogClock()
        updateLayerProperties()
    }
    
    func createAnalogClock() {
        layoutMinuteHandLayer()
        layoutHourHandLayer()
        
        if enableClockSecondHand == true {
            layoutSecondHandLayer()
        } else {
            layoutWatchRingLayer()
        }
    }
    
    func layoutBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            
            let rect = CGRectInset(bounds, lineWidth / 2.0,
                                   lineWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            backgroundLayer.path = path.CGPath
            backgroundLayer.fillColor = backgroundLayerColor.CGColor
            backgroundLayer.lineWidth = lineWidth
        }
        backgroundLayer.frame = layer.bounds
    }
    
    func layoutBackgroundImageLayer() {
        if backgroundImageLayer == nil {
            let maskLayer = CAShapeLayer()
            let dx = lineWidth + 3.0
            let insetBounds = CGRectInset(self.bounds, dx, dx)
            let innerPath = UIBezierPath(ovalInRect: insetBounds)
            maskLayer.path = innerPath.CGPath
            maskLayer.fillColor = UIColor.blackColor().CGColor
            maskLayer.frame = self.bounds
            layer.addSublayer(maskLayer)
            
            backgroundImageLayer = CAShapeLayer()
            backgroundImageLayer.mask = maskLayer
            backgroundImageLayer.frame = self.bounds
            backgroundImageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(backgroundImageLayer)
        }
    }
    
    func layoutWatchRingLayer() {
        if ringProgress == 0 {
            if ringLayer != nil {
                ringLayer.strokeEnd = 0.0
            }
        }
        
        if ringLayer == nil{
            ringLayer = CAShapeLayer()
            layer.addSublayer(ringLayer)
            let dx = ringThickness / 2.0
            let rect = CGRectInset(bounds, dx, dx)
            let path = UIBezierPath(ovalInRect: rect)
            ringLayer.transform = CATransform3DMakeRotation(CGFloat(-(M_PI/2)), 0, 0, 1)
            ringLayer.strokeColor = ringColor.CGColor
            ringLayer.path = path.CGPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            ringLayer.strokeStart = 0.0
        }
        ringLayer.strokeEnd = ringProgress / 60.0
        ringLayer.frame = layer.bounds
    }
    
    func layoutSecondHandLayer() {
        if secondHandLayer == nil {
            secondHandLayer = createClockHand(CGPointMake(1.0, 1.0), handLength: 20.0, handWidth: 4.0, handAlpha: 1.0, handColor: secondHandColor)
            layer.addSublayer(secondHandLayer)
        }
    }
    
    func layoutMinuteHandLayer() {
        if minuteHandLayer == nil {
            minuteHandLayer = createClockHand(CGPointMake(1.0, 1.0), handLength: 26.0, handWidth: 12.0, handAlpha: 1.0, handColor: minuteHandColor)
            layer.addSublayer(minuteHandLayer)
        }
    }
    
    func layoutHourHandLayer() {
        if hourHandLayer == nil {
            hourHandLayer = createClockHand(CGPointMake(1.0, 1.0), handLength: 52.0, handWidth:12.0, handAlpha: 1.0, handColor: hourHandColor)
            layer.addSublayer(hourHandLayer)
        }
    }
    
    func updateLayerProperties() {
        if ringLayer != nil {
            ringLayer.strokeEnd = ringProgress / 60.0
        }
        
        if enableClockSecondHand == true {
            setHideSecondClockHand(false)
            setHideRingLayer(true)
        } else if enableClockSecondHand == false {
            setHideSecondClockHand(true)
            setHideRingLayer(false)
        } else {
            setHideRingLayer(true)
            setHideSecondClockHand(true)
        }
        
        if enableColorBackground == true {
            setHideImageBackground(true)
        } else {
            setHideImageBackground(false)
        }
        
        if backgroundLayer != nil {
            backgroundLayer.fillColor = backgroundLayerColor.CGColor
        }
        if backgroundImageLayer != nil {
            if let image = backgroundImage {
                backgroundImageLayer.contents = image.CGImage
            }
        }
    }
    
    func setHideImageBackground(willHide: Bool) {
        if backgroundImageLayer != nil {
            backgroundImageLayer.hidden = willHide
        }
    }
    
    func setHideSecondClockHand(willHide: Bool) {
        if secondHandLayer != nil {
            secondHandLayer.hidden = willHide
        }
    }
    
    func setHideRingLayer(willHide: Bool) {
        if ringLayer != nil {
            ringLayer.hidden = willHide
        }
    }
    
    func createClockHand(anchorPoint: CGPoint, handLength: CGFloat, handWidth: CGFloat, handAlpha: CGFloat, handColor: UIColor) -> CAShapeLayer {
        let handLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(1.0, handLength))
        path.addLineToPoint(CGPointMake(1.0, bounds.size.height / 2.0))
        handLayer.bounds = CGRectMake(0.0, 0.0, 1.0, bounds.size.height / 2.0)
        handLayer.anchorPoint = anchorPoint
        handLayer.position = CGPointMake(CGRectGetMidX(bounds),CGRectGetMidY(bounds))
        handLayer.lineWidth = handWidth
        handLayer.opacity = Float(handAlpha)
        handLayer.strokeColor = handColor.CGColor
        handLayer.path = path.CGPath
        handLayer.lineCap = kCALineCapRound
        
        return handLayer
    }
    
    func grabDateComponents(dateString: String) -> [String] {
        let dateArray = dateString.componentsSeparatedByString(":")
        return dateArray
    }
    
    func startTimeWithTimeZone(timezone: String) {
        endTime()
        currentTimeZone = timezone
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ZWWatchView.animateAnalogClock), userInfo: nil, repeats: true)
    }
    
    func endTime() {
        timer.invalidate()
    }
    
    func animateAnalogClock() {
        let now = NSDate()
    
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: currentTimeZone)
        dateFormatter.dateFormat = "hh:mm:ss"
        
        let dateComponents = grabDateComponents(dateFormatter.stringFromDate(now))
        
        let hours = Int(dateComponents[0])
        let minutes = Int(dateComponents[1])
        let seconds = Int(dateComponents[2])
        
        let minutesIntoDay = CGFloat(hours!) * 60.0 + CGFloat(minutes!)
        let pminutesIntoDay = CGFloat(minutesIntoDay) / (12.0 * 60.0)
        let minutesIntoHour = CGFloat(minutes!) / 60.0
        let secondsIntoMinute = CGFloat(seconds!) / 60.0
       
        if enableClockSecondHand == true {
            if secondHandLayer != nil {
                secondHandLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI * 2.0) * secondsIntoMinute, 0, 0, 1)
            }
        } else {
            if ringLayer != nil {
                ringProgress = CGFloat(seconds!)
            }
        }
        
        if minuteHandLayer != nil {
            minuteHandLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI * 2) * minutesIntoHour, 0, 0, 1)
        }
        
        if hourHandLayer != nil {
            hourHandLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI * 2) * pminutesIntoDay, 0, 0, 1)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

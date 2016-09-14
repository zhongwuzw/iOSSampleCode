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
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.lightGray { didSet { updateLayerProperties() }
    }
    
    var backgroundImageLayer: CALayer!
    @IBInspectable var backgroundImage: UIImage? {
        didSet  { updateLayerProperties() }
    }
    
    var secondHandLayer: CAShapeLayer!
    @IBInspectable var secondHandColor: UIColor = UIColor.red
    
    var minuteHandLayer: CAShapeLayer!
    @IBInspectable var minuteHandColor: UIColor = UIColor.white
    
    var hourHandLayer: CAShapeLayer!
    @IBInspectable var hourHandColor: UIColor = UIColor.white
    
    @IBInspectable var lineWidth: CGFloat = 1.0
    
    var ringLayer: CAShapeLayer!
    @IBInspectable var ringThickness: CGFloat = 2.0
    @IBInspectable var ringColor: UIColor = UIColor.blue
    @IBInspectable var ringProgress: CGFloat = 45.0/60 {
        didSet { updateLayerProperties() }
    }
    
    var timer = Timer()
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
            
            let rect = bounds.insetBy(dx: lineWidth / 2.0,
                                   dy: lineWidth / 2.0)
            let path = UIBezierPath(ovalIn: rect)
            
            backgroundLayer.path = path.cgPath
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
            backgroundLayer.lineWidth = lineWidth
        }
        backgroundLayer.frame = layer.bounds
    }
    
    func layoutBackgroundImageLayer() {
        if backgroundImageLayer == nil {
            let maskLayer = CAShapeLayer()
            let dx = lineWidth + 3.0
            let insetBounds = self.bounds.insetBy(dx: dx, dy: dx)
            let innerPath = UIBezierPath(ovalIn: insetBounds)
            maskLayer.path = innerPath.cgPath
            maskLayer.fillColor = UIColor.black.cgColor
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
            let rect = bounds.insetBy(dx: dx, dy: dx)
            let path = UIBezierPath(ovalIn: rect)
            ringLayer.transform = CATransform3DMakeRotation(CGFloat(-(M_PI/2)), 0, 0, 1)
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.path = path.cgPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            ringLayer.strokeStart = 0.0
        }
        ringLayer.strokeEnd = ringProgress / 60.0
        ringLayer.frame = layer.bounds
    }
    
    func layoutSecondHandLayer() {
        if secondHandLayer == nil {
            secondHandLayer = createClockHand(CGPoint(x: 1.0, y: 1.0), handLength: 20.0, handWidth: 4.0, handAlpha: 1.0, handColor: secondHandColor)
            layer.addSublayer(secondHandLayer)
        }
    }
    
    func layoutMinuteHandLayer() {
        if minuteHandLayer == nil {
            minuteHandLayer = createClockHand(CGPoint(x: 1.0, y: 1.0), handLength: 26.0, handWidth: 12.0, handAlpha: 1.0, handColor: minuteHandColor)
            layer.addSublayer(minuteHandLayer)
        }
    }
    
    func layoutHourHandLayer() {
        if hourHandLayer == nil {
            hourHandLayer = createClockHand(CGPoint(x: 1.0, y: 1.0), handLength: 52.0, handWidth:12.0, handAlpha: 1.0, handColor: hourHandColor)
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
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
        }
        if backgroundImageLayer != nil {
            if let image = backgroundImage {
                backgroundImageLayer.contents = image.cgImage
            }
        }
    }
    
    func setHideImageBackground(_ willHide: Bool) {
        if backgroundImageLayer != nil {
            backgroundImageLayer.isHidden = willHide
        }
    }
    
    func setHideSecondClockHand(_ willHide: Bool) {
        if secondHandLayer != nil {
            secondHandLayer.isHidden = willHide
        }
    }
    
    func setHideRingLayer(_ willHide: Bool) {
        if ringLayer != nil {
            ringLayer.isHidden = willHide
        }
    }
    
    func createClockHand(_ anchorPoint: CGPoint, handLength: CGFloat, handWidth: CGFloat, handAlpha: CGFloat, handColor: UIColor) -> CAShapeLayer {
        let handLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 1.0, y: handLength))
        path.addLine(to: CGPoint(x: 1.0, y: bounds.size.height / 2.0))
        handLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 1.0, height: bounds.size.height / 2.0)
        handLayer.anchorPoint = anchorPoint
        handLayer.position = CGPoint(x: bounds.midX,y: bounds.midY)
        handLayer.lineWidth = handWidth
        handLayer.opacity = Float(handAlpha)
        handLayer.strokeColor = handColor.cgColor
        handLayer.path = path.cgPath
        handLayer.lineCap = kCALineCapRound
        
        return handLayer
    }
    
    func grabDateComponents(_ dateString: String) -> [String] {
        let dateArray = dateString.components(separatedBy: ":")
        return dateArray
    }
    
    func startTimeWithTimeZone(_ timezone: String) {
        endTime()
        currentTimeZone = timezone
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ZWWatchView.animateAnalogClock), userInfo: nil, repeats: true)
    }
    
    func endTime() {
        timer.invalidate()
    }
    
    func animateAnalogClock() {
        let now = Date()
    
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: currentTimeZone)
        dateFormatter.dateFormat = "hh:mm:ss"
        
        let dateComponents = grabDateComponents(dateFormatter.string(from: now))
        
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

//
//  ObviousAnimationViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/19.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class ObviousAnimationViewController: UIViewController {
    
    var changedColor = UIColor.randomColor()
    
    lazy var animatedLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = self.changedColor.CGColor
        layer.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        layer.position = CGPoint(x: self.view.bounds.size.width / 2, y: 100.0)
        
        let innerLyaer = CALayer()
        innerLyaer.frame = CGRectMake(0, 0, 10.0, 10.0)
        innerLyaer.position = CGPoint(x: 50.0, y: 5.0)
        innerLyaer.backgroundColor = UIColor.blackColor().CGColor
        layer.addSublayer(innerLyaer)
        return layer
    }()
    
    lazy var clockLayer: CALayer = {
        let clock = CALayer()
        clock.backgroundColor = UIColor.colorWithHexString("0xdeb39b").CGColor
        clock.frame = CGRect(x: 0, y: 0, width: 150.0, height: 150.0)
        clock.position = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)
        clock.cornerRadius = 75.0
        clock.borderWidth = 5.0
        clock.borderColor = UIColor.colorWithHexString("0x2f2f2f").CGColor
        return clock
    }()
    
    lazy var hourLayer: CALayer = {
        let hour = CALayer()
        hour.allowsEdgeAntialiasing = true
        hour.frame = CGRect(x: 0, y: 0, width: 5.0, height: 45.0)
        hour.backgroundColor = UIColor.colorWithHexString("0x2f2f2f").CGColor
        hour.position = CGPoint(x: 75.0, y: 75.0)
        hour.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        return hour
    }()
    
    lazy var minuteLayer: CALayer = {
        let minute = CALayer()
        minute.allowsEdgeAntialiasing = true
        minute.frame = CGRect(x: 0, y: 0, width: 5.0, height: 70.0)
        minute.backgroundColor = UIColor.colorWithHexString("0x2f2f2f").CGColor
        minute.position = CGPoint(x: 75.0, y: 75.0)
        minute.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        return minute
    }()
    
    lazy var secondLayer: CALayer = {
        let second = CALayer()
        second.allowsEdgeAntialiasing = true
        second.frame = CGRect(x: 0, y: 0, width: 3.0, height: 70.0)
        second.backgroundColor = UIColor.colorWithHexString("0x2f2f2f").CGColor
        second.position = CGPoint(x: 75.0, y: 75.0)
        second.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        return second
    }()
    
    lazy var timer: NSTimer = {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.layer.addSublayer(animatedLayer)
        view.layer.addSublayer(clockLayer)
        
        //clock hand
        clockLayer.addSublayer(hourLayer)
        clockLayer.addSublayer(minuteLayer)
        clockLayer.addSublayer(secondLayer)
        
        //初始化时间显示
        updateHandsAnimated(false)
        timer.fire()
        
        //drawLayer
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 50.0, y: 500.0))
        bezierPath.addCurveToPoint(CGPoint(x: 300.0, y: 500.0), controlPoint1: CGPoint(x: 125.0, y: 350.0), controlPoint2: CGPoint(x: 225.0, y: 650.0))
        //layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.fillColor = UIColor.lightGrayColor().CGColor
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
        
        let startPoint = CALayer()
        startPoint.frame = CGRectMake(0, 0, 80.0, 60.0)
        startPoint.position = CGPoint(x: 50.0, y: 500.0)
        startPoint.contents = UIImage(named: "ship")?.CGImage
        startPoint.contentsGravity = kCAGravityResizeAspect
        view.layer.addSublayer(startPoint)
        
        let pathAnimation = CAKeyframeAnimation()
        pathAnimation.keyPath = "position"
        pathAnimation.duration = 4.0
        pathAnimation.path = bezierPath.CGPath
        pathAnimation.rotationMode = kCAAnimationRotateAuto
        pathAnimation.repeatCount = 5
        
        startPoint.addAnimation(pathAnimation, forKey: nil)
    }
    
    func changeColor() {
        changedColor = UIColor.randomColor()
        
        //显示动画
//        let animation = CABasicAnimation()
//        animation.keyPath = "backgroundColor"
//        animation.toValue = changedColor.CGColor
//        animation.duration = 1.0
//        animation.delegate = self
//        animatedLayer.addAnimation(animation, forKey: nil)
        
        //关键帧动画
        //color
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [UIColor.redColor().CGColor,
                            UIColor.blueColor().CGColor,
                            UIColor.greenColor().CGColor,
                            UIColor.yellowColor().CGColor]
        animatedLayer.addAnimation(animation, forKey: nil)
        
        //rotation
        let rotationAnimation = CABasicAnimation()
        rotationAnimation.keyPath = "transform.rotation"
        rotationAnimation.duration = 2.0
        rotationAnimation.byValue = CGFloat(M_PI)
        animatedLayer.addAnimation(rotationAnimation, forKey: nil)
    }
    
    func tick() {
        updateHandsAnimated(true)
    }
    
    func updateHandsAnimated(animated: Bool) {
        let calendar  = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: NSDate())
        
        let hourAngle   = (CGFloat(components.hour) / 12.0) * CGFloat(M_PI) * 2.0
        let miniteAngle = (CGFloat(components.minute) / 60.0) * CGFloat(M_PI) * 2.0
        let secondAngle = (CGFloat(components.second) / 60.0) * CGFloat(M_PI) * 2.0
        
        setAngle(hourAngle, handLayer: hourLayer, animated: animated)
        setAngle(miniteAngle, handLayer: minuteLayer, animated: animated)
        setAngle(secondAngle, handLayer: secondLayer, animated: animated)
    }
    
    func setAngle(angle: CGFloat, handLayer:CALayer, animated: Bool) {
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        if animated {
            let animation = CABasicAnimation()
            updateHandsAnimated(false)
            animation.keyPath = "transform"
            animation.toValue = NSValue(CATransform3D: transform)
            animation.duration = 0.5
            animation.delegate = self
            animation.setValue(handLayer, forKey: "layer")
            animation.setValue(animation.toValue, forKey: "transform")
            handLayer.addAnimation(animation, forKey: nil)
        } else {
            handLayer.transform = transform
        }
    }
}

extension ObviousAnimationViewController {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //get the touch point
        let point = touches.first!.locationInView(self.view)
        //check if we've tapped the moving layer
        if let _ = animatedLayer.hitTest(point) {
            changeColor()
        } else {
            animatedLayer.position = point
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        animatedLayer.backgroundColor = changedColor.CGColor
        CATransaction.commit()
        
//        if let layer = anim.valueForKey("layer"),
//            let transform = anim.valueForKey("transform") {
//            if layer is CALayer && transform is NSValue {
//                print("udpate")
//                (layer as! CALayer).transform = (transform as! NSValue).CATransform3DValue
//            }
//        }
    }
}

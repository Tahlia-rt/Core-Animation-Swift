//
//  TimingViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/20.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit


class TimingViewController: UIViewController {
    
    var duration: CGFloat = 1.0
    var timeOff:  CGFloat = 0.0
    var lastStep: NSTimeInterval = 0.0
    var fromValue: NSValue?
    var toValue:   NSValue?
    
    lazy var ballLayer: CALayer = {
        let ballLayer = CALayer()
        ballLayer.frame = CGRect(x: 0, y: 0, width: 26.0, height: 26.0)
        ballLayer.position = CGPoint(x: 150.0, y: 112.5)
        ballLayer.contents = UIImage(named: "ball")?.CGImage
        ballLayer.contentsGravity = kCAGravityResizeAspect
        return ballLayer
    }()
    
    var timer: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let imagelayer = CALayer()
        imagelayer.contents = UIImage(named: "door")?.CGImage
        imagelayer.frame = CGRect(origin: CGPointZero, size: CGSize(width: 200.0, height: 150.0))
        imagelayer.position = CGPoint(x: view.center.x, y: view.center.y + 200.0)
        view.layer.addSublayer(imagelayer)
        
        //perspective
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        view.layer.transform = perspective
        
        //animation
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = CGFloat(-M_PI_2)
        animation.duration = 2.0
        animation.repeatCount = FLT_MAX
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        imagelayer.addAnimation(animation, forKey: nil)
        
        // MARK: - Ball
        let container = CALayer()
        container.backgroundColor = UIColor.lightGrayColor().CGColor
        container.frame = CGRect(x: 0, y: 0, width: 300.0, height: 225.0)
        container.position = CGPoint(x: view.center.x, y: view.center.y)
        view.layer.addSublayer(container)
        
        container.addSublayer(ballLayer)
        
        animate()
    }
    
    func animate() {
        ballLayer.position = CGPoint(x: 150.0, y: 112.5)
        //animation
        duration = 1.0
        timeOff = 0.0
        fromValue = NSValue(CGPoint: CGPoint(x: 150.0, y: 112.5))
        toValue   = NSValue(CGPoint: CGPoint(x: 150.0, y: 211.0))
        //stop the timer if it's already running
        if let timer = timer {
            timer.invalidate()
        }
//        timer = NSTimer.scheduledTimerWithTimeInterval(1/60.0, target: self, selector: #selector(step(_:)), userInfo: nil, repeats: true)
        lastStep = CACurrentMediaTime()
        timer = CADisplayLink(target: self, selector: #selector(step(_:)))
        timer?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    // MARK: - Action
    func step(timer: CADisplayLink) {
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - lastStep
        lastStep = thisStep
        timeOff = min(timeOff + CGFloat(stepDuration), self.duration)
        //get normalized time offset
       var time = timeOff / duration
        //apply easing
        time = bounceEaseOut(time)
        //interpolate position
        let position = interpolateFromValue(fromValue!, toValue: toValue!, time: time)
        ballLayer.position = position.CGPointValue()
        //stop the timer if we've reached the end of the animation
        if timeOff >= duration {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    // MARK: - Private
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        return (to - from) * time + from
    }
    
    func interpolateFromValue(fromValue: AnyObject, toValue: AnyObject, time: CGFloat) -> AnyObject {
        if fromValue is NSValue {
            let type = fromValue.objCType
            if String.fromCString(type) == "{CGPoint=dd}" {
                let from = fromValue.CGPointValue()
                let  to  = toValue.CGPointValue()
                let result = CGPoint(x: interpolate(from.x, to: to.x, time: time),
                                     y: interpolate(from.y, to: to.y, time: time))
                return NSValue(CGPoint: result)
            }
        }
        
        return time < 0.5 ? fromValue : toValue
    }
    
    func bounceEaseOut(t : CGFloat) -> CGFloat {
        if t < (4.0/11.0) {
            return (121 * t * t) / 16.0
        } else if t < (8.0/11.0) {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
        }  else if t < (9.0/10.0) {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }
}

extension TimingViewController {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        animate()
    }
}

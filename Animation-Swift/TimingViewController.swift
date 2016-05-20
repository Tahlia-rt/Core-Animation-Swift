//
//  TimingViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/20.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class TimingViewController: UIViewController {
    
    lazy var ballLayer: CALayer = {
        let ballLayer = CALayer()
        ballLayer.frame = CGRect(x: 0, y: 0, width: 26.0, height: 26.0)
        ballLayer.position = CGPoint(x: 150.0, y: 112.5)
        ballLayer.contents = UIImage(named: "ball")?.CGImage
        ballLayer.contentsGravity = kCAGravityResizeAspect
        return ballLayer
    }()
    
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
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.values = [NSValue(CGPoint: CGPoint(x: 150.0, y: 112.5)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 211.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 140.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 211.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 165.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 211.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 175.0)),
                            NSValue(CGPoint: CGPoint(x: 150.0, y: 211.0))]
        
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                                     CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1]
        ballLayer.addAnimation(animation, forKey: nil)
        
        ballLayer.position = CGPoint(x: 150.0, y: 211.0)
    }
}

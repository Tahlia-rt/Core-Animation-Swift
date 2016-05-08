//
//  CircularLoaderView.swift
//  Animation-Swift
//
//  Created by sean on 16/5/8.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class CircularLoaderView: UIView {
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                circlePathLayer.strokeEnd = 1
            } else if newValue < 0 {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    // MARK: - Private
    private func configure() {
        //backgroundColor
        backgroundColor = UIColor.whiteColor()
        //config the layer
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = UIColor.redColor().CGColor
        layer.addSublayer(circlePathLayer)
        
        progress = 0
    }
    
    private func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = UIBezierPath(ovalInRect: circleFrame()).CGPath
    }
    
    func reveal() {
        //set the backgroundColor
        backgroundColor = UIColor.clearColor()
        
        //clear the border
        progress = 1
        
        //clear animation
        circlePathLayer.removeAnimationForKey("strokeEnd")
        circlePathLayer.removeFromSuperlayer()
        
        //add mask to superView
        superview?.layer.mask = circlePathLayer
        
        //start the animation
//        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let finalRadius = sqrt(centerX*centerX + centerY*centerY)
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = UIBezierPath(ovalInRect: outerRect).CGPath
        
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        
        // set the mask ring
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2*finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        //property animation
        let linewidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        linewidthAnimation.fromValue = fromLineWidth
        linewidthAnimation.toValue = 2*finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        //animationGroup
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, linewidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        //remove the mask to show the view under 'self'
        superview?.layer.mask = nil
    }
}

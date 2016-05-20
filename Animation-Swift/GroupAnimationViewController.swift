//
//  GroupAnimationViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/20.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class GroupAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //create path
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: view.center.x, y: 50.0))
        path.addCurveToPoint(CGPointMake(view.center.x, 650.0), controlPoint1: CGPoint(x: 0, y: 250.0), controlPoint2: CGPoint(x: view.center.x + 200.0, y: 450.0))
        //draw layer
        let pathLayer = CAShapeLayer()
        pathLayer.strokeColor = UIColor.redColor().CGColor
        pathLayer.fillColor = UIColor.lightGrayColor().CGColor
        pathLayer.path = path.CGPath
        view.layer.addSublayer(pathLayer)
        
        //animated layer
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 64.0, height: 64.0)
        colorLayer.position = CGPoint(x: view.center.x, y: 50.0)
        colorLayer.backgroundColor = UIColor.grayColor().CGColor
        view.layer.addSublayer(colorLayer)
        
        //position
        let positionAnimation = CAKeyframeAnimation()
        positionAnimation.keyPath = "position"
        positionAnimation.path = path.CGPath
        positionAnimation.rotationMode = kCAAnimationRotateAuto
        
        //color
        let colorAnimation = CABasicAnimation()
        colorAnimation.keyPath = "backgroundColor"
        colorAnimation.toValue = UIColor.redColor().CGColor
        
        //group 
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, colorAnimation]
        groupAnimation.duration = 4.0
        
        //add
        colorLayer.addAnimation(groupAnimation, forKey: nil)
        
        
    }
}

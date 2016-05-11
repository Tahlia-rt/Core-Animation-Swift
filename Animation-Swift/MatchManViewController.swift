//
//  MatchManViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/11.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class MatchManViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let centerX = self.view.centerX
        let startY:         CGFloat = 100.0
        let singleWidth:    CGFloat = 25.0
        
        
        let path = UIBezierPath()
        //start draw
        //head
        path.addArcWithCenter(CGPoint(x: centerX, y: startY), radius: singleWidth, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        //neck
        path.moveToPoint(CGPoint(x: centerX, y: startY + singleWidth))
        path.addLineToPoint(CGPoint(x: centerX, y: startY + 3*singleWidth))
        //let leg
        path.addLineToPoint(CGPoint(x: centerX - singleWidth, y: startY + 5*singleWidth))
        //right let
        path.moveToPoint(CGPoint(x: centerX, y: startY + 3*singleWidth))
        path.addLineToPoint(CGPoint(x: centerX + singleWidth, y: startY + 5*singleWidth))
        //hand
        path.moveToPoint(CGPoint(x: centerX - 2*singleWidth, y: startY + 2*singleWidth))
        path.addLineToPoint(CGPoint(x: centerX + 2*singleWidth, y: startY + 2*singleWidth))
        
        
        let matchMan = CAShapeLayer()
        matchMan.strokeColor = UIColor.redColor().CGColor
        matchMan.fillColor = UIColor.clearColor().CGColor
        matchMan.lineWidth = 5.0
        matchMan.lineJoin = kCALineJoinRound
        matchMan.lineCap = kCALineCapRound
        matchMan.path = path.CGPath
        
        view.layer.addSublayer(matchMan)
        
        //roundedView
        let rect = CGRect(x: centerX - 50.0, y: 300.0, width: 100.0, height: 100.0)
        let radi = CGSize(width: 20.0, height: 20.0)
        let corners = (UIRectCorner.TopRight.rawValue | UIRectCorner.BottomRight.rawValue | UIRectCorner.BottomLeft.rawValue)
        let roundedPath = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: corners), cornerRadii: radi)
        
        let roudedLayer = CAShapeLayer()
        roudedLayer.strokeColor = UIColor.redColor().CGColor
        roudedLayer.fillColor = UIColor.clearColor().CGColor
        roudedLayer.lineWidth = 5.0
        roudedLayer.lineJoin = kCALineJoinRound
        roudedLayer.lineCap = kCALineCapRound
        roudedLayer.path = roundedPath.CGPath
        view.layer.addSublayer(roudedLayer)
        
        let drawString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis"
        drawText(drawString, inFrame: CGRectMake(0, 450, view.width, 130.0))
    }
    
    func drawText(text: String, inFrame: CGRect) {
        let textLayer = CATextLayer()
        textLayer.frame = inFrame
        self.view.layer.addSublayer(textLayer)
        
        //set text attributes
        textLayer.foregroundColor = UIColor.blackColor().CGColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.wrapped = true
        //font
        let font = UIFont.systemFontOfSize(15.0)
        //set font
        let fontName = font.fontName as CFStringRef
        let fontRef = CGFontCreateWithFontName(fontName)
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize
        
        //scale
        textLayer.contentsScale = UIScreen.mainScreen().scale
        
        textLayer.string = text
    }
}

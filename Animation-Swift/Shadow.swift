//
//  Chapter4.swift
//  Animation-Swift
//
//  Created by sean on 16/5/7.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class Chapter4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bluelayer = CALayer()
        bluelayer.frame = CGRectMake(0, 0, 100.0, 100.0)
        bluelayer.backgroundColor = UIColor.blueColor().CGColor
        bluelayer.position = self.view.center
        //阴影
        bluelayer.shadowOpacity = 1.0
//        bluelayer.shadowRadius = 10.0
//        bluelayer.shadowOffset = CGSizeMake(0, 10.0)
        view.layer.addSublayer(bluelayer)
        
        // Do any additional setup after loading the view.
        
        //shadowPath
        let ref = CGPathCreateMutable()
        CGPathAddRect(ref, nil, CGRectMake(0, 0, 200.0, 200.0))
        bluelayer.shadowPath = ref
        
        //maskView
        let redLayer = CALayer()
        redLayer.frame = CGRectMake(0, 0, 100.0, 100.0)
        redLayer.backgroundColor = UIColor.redColor().CGColor
        redLayer.position = CGPointMake(view.centerX, 100)
        view.layer.addSublayer(redLayer)
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.clearColor().CGColor
        maskLayer.lineWidth = 3.0
        maskLayer.strokeColor = UIColor.yellowColor().CGColor
        maskLayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 50.0, 50.0)).CGPath
        redLayer.mask = maskLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  ViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/6.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class Chapter1: UIViewController {
    
    var top: CGFloat     = 0.0
    var bottom: CGFloat  = 0.0
    var left: CGFloat    = 0.0
    var right: CGFloat   = 0.0
    
    let snowImage = UIImage(named: "cube")
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.redColor()
        bottomView.y = self.view.centerY + 120
        bottomView.size = CGSizeMake(self.view.width, 110.0 * 1.5)
        bottomView.layer.contents = self.snowImage!.CGImage
        //contentsGravity = contentMode
        bottomView.layer.contentsGravity = "resize"
//        bottomView.layer.contentsScale = self.snowImage!.scale
        //contentsCenter 拉伸
        return bottomView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bluelayer = CALayer()
        bluelayer.frame = CGRectMake(0, 0, 100.0, 100.0)
        bluelayer.backgroundColor = UIColor.blueColor().CGColor
        bluelayer.position = CGPointMake(self.view!.centerX, 50.0)
        view.layer.addSublayer(bluelayer)
        
        view.addSubview(bottomView)
        
        let topView = UIView()
        topView.backgroundColor = UIColor.redColor()
        topView.y = self.view.centerY - 120
        topView.size = CGSizeMake(self.view.width, 110.0)
        topView.layer.contents = snowImage!.CGImage
        //contentsGravity = contentMode
        topView.layer.contentsGravity = "resizeAspect"
        topView.layer.contentsScale = snowImage!.scale
        //contentsRect 剪裁
        topView.layer.contentsRect = CGRectMake(0.25, 0.25, 0.5, 0.5)
        view.addSubview(topView)
        
        let centerView = UIView()
        centerView.backgroundColor = UIColor.redColor()
        centerView.y = self.view.centerY
        centerView.size = CGSizeMake(self.view.width, 110.0)
        centerView.layer.contents = snowImage!.CGImage
        //contentsGravity = contentMode
        centerView.layer.contentsGravity = "resizeAspect"
        centerView.layer.contentsScale = snowImage!.scale
        view.addSubview(centerView)
        
        let topButton = UIButton()
        topButton.setTitle("上", forState: .Normal)
        topButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        topButton.sizeToFit()
        topButton.addTarget(self, action: #selector(handleTop(_:)), forControlEvents: .TouchUpInside)
        topButton.centerX = view.width / 2.0
        view.addSubview(topButton)
        
        let bottomButton = UIButton()
        bottomButton.setTitle("下", forState: .Normal)
        bottomButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        bottomButton.sizeToFit()
        bottomButton.centerX = view.width / 2.0
        bottomButton.y = 100.0
        bottomButton.addTarget(self, action: #selector(handleBottom(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(bottomButton)
        
        let leftButon = UIButton()
        leftButon.setTitle("左", forState: .Normal)
        leftButon.setTitleColor(UIColor.blackColor(), forState: .Normal)
        leftButon.sizeToFit()
        leftButon.x = view.centerX - 40
        leftButon.y = 50
        view.addSubview(leftButon)
        
        let rightButton = UIButton()
        rightButton.setTitle("右", forState: .Normal)
        rightButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        rightButton.sizeToFit()
        rightButton.x = view.centerX + 20
        rightButton.y = 50
        view.addSubview(rightButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTop(sender: UIButton) {
        top = top + 0.025
        bottomView.layer.contentsCenter = CGRectMake(top, 0, 1 - top - 0.05, 1)
        print(bottomView.layer.contentsCenter)
    }
    
    func handleBottom(sender: UIButton) {
        top = top - 0.025
        bottomView.layer.contentsCenter = CGRectMake(top, 0, 1 - top - 0.05, 1)
        print(bottomView.layer.contentsCenter)
    }
}


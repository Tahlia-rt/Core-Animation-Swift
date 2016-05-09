//
//  TransformViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/9.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class TransformViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var outerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        image1.layer.setAffineTransform(CGAffineTransformMakeShear(1, y: 0))
        
        //透视和投影
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 1000.0
        view.layer.sublayerTransform = perspective
        
        //图层的背面 为当前显示界面的镜像
        //当设置不绘制背面,背面的镜像便不会显示
//        image4.layer.transform = CATransform3DMakeRotation(-CGFloat(M_PI), 1, 0, 0)
//        image5.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0)
        
        //旋转外部图层,然后旋转内部图层
        var outer = CATransform3DIdentity
        outer.m34 = -1.0 / 500.0
        outer = CATransform3DRotate(outer, CGFloat(M_PI_4), 0, 1, 0)
        outerView.layer.transform = outer
        
        var inner = CATransform3DIdentity;
        inner.m34 = -1.0 / 500.0;
        inner = CATransform3DRotate(inner, -CGFloat(M_PI_4), 0, 1, 0);
        image4.layer.transform = inner
    }
    
    private func CGAffineTransformMakeShear(x: CGFloat, y: CGFloat) -> CGAffineTransform {
        var transform = CGAffineTransformIdentity
        transform.c = -x
        transform.b = y
        return transform
    }
}

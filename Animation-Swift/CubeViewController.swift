//
//  CubeViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/9.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit
import GLKit

class CubeViewController: UIViewController {

    let offset: CGFloat = 70.0
    
    let AMBIENT_LIGHT: Float = 0.5
    let LIGHT_DIRECTION: (Float, Float, Float) = (0, 1, -0.5)
    
    deinit {
        
    }
    
    var faces = [UIView]()
    
    lazy var container: UIView = {
        let container = UIView()
        container.frame = self.view.bounds
        self.view.addSubview(container)
        return container;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGrayColor()
        
        // Do any additional setup after loading the view.
        for index in 1...6 {
            let face = UIView()
            face.size = CGSize(width: offset * 2, height: offset * 2)
            face.backgroundColor = UIColor.whiteColor()
            
            let button = UIButton()
            button.backgroundColor = UIColor.clearColor()
            button.setTitle(String(index), forState: .Normal)
            button.setTitleColor(UIColor.randomColor(), forState: .Normal)
            button.size = CGSize(width: 100.0, height: 100.0)
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(25.0)
            button.center = face.center
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.borderWidth = 1.0
            face.addSubview(button)
            
            faces.append(face)
        }
        
        //container的透视效果
        var perspective = CATransform3DIdentity
        //增加透视属性
        perspective.m34 = -1 / 500.0
        perspective = CATransform3DRotate(perspective, -CGFloat(M_PI_4), 1, 0, 0);
        perspective = CATransform3DRotate(perspective, -CGFloat(M_PI_4), 0, 1, 0);
        container.layer.sublayerTransform = perspective
        
        //face 1
        //沿Z轴向前,拉近与眼镜的视距
        var transform = CATransform3DMakeTranslation(0, 0, offset)
        addFace(0, transform: transform)
        
        //face2
        //沿X轴正方向移动,正方向旋转九十度
        transform = CATransform3DMakeTranslation(offset, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
        addFace(1, transform: transform)

        //face3
        //沿Y轴负方向移动,正方向旋转九十度
        transform = CATransform3DMakeTranslation(0, -offset, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0)
        addFace(2, transform: transform)

        //face4
        transform = CATransform3DMakeTranslation(0, offset, 0)
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 1, 0, 0)
        addFace(3, transform: transform)

        //face5
        transform = CATransform3DMakeTranslation(-offset, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat(M_PI_2), 0, 1, 0)
        addFace(4, transform: transform)

        //face6
        transform = CATransform3DMakeTranslation(0, 0, -offset)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0)
        addFace(5, transform: transform)
    }
    
    private func addFace(index: Int, transform: CATransform3D) {
        let face = faces[index]
        container.addSubview(face)
        let containerSize = self.container.size
        face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0)
        face.layer.transform = transform
        
        //apply lighting
        applyLightingToFace(face.layer)
    }
    
    private func applyLightingToFace(face: CALayer) {
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        
        //start transform
        let transform = face.transform
        let matrix4 = GLKMatrix4(m: (Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14)
            , Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24)
            , Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34)
            , Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44)))
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        
        // get face normal
        var normal = GLKVector3Make(0, 0, 1.0)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        
        //get dot product with light direction
        let light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION.0, LIGHT_DIRECTION.1, LIGHT_DIRECTION.2))
        let dotProduct = GLKVector3DotProduct(light, normal)
        //set lighting layer opacity
        
        let shadow = 1 + dotProduct - AMBIENT_LIGHT
        let color = UIColor(white: 0, alpha: min(CGFloat(shadow), 0.5))
        layer.backgroundColor = color.CGColor
    }
}

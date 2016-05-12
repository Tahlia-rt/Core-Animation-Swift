//
//  TransformLayerViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/12.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class TransformLayerViewController: UIViewController {
    
    let lineWidth: CGFloat = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //透视效果
        var transfrom = CATransform3DIdentity
        transfrom.m34 = -1.0 / 500.0
        view.layer.sublayerTransform = transfrom
        
        var cubeTransform = CATransform3DIdentity
        cubeTransform = CATransform3DTranslate(cubeTransform, 0, -lineWidth, 0)
        cubeTransform = CATransform3DRotate(cubeTransform, CGFloat(M_PI_4), 0, 1, 0)
        cubeTransform = CATransform3DRotate(cubeTransform, CGFloat(M_PI_4 * 0.5), 1, 0, 0)
        let cube = cubeWithTransform(cubeTransform)
        view.layer.addSublayer(cube)
        
        let replicator = CAReplicatorLayer()
        replicator.backgroundColor = UIColor.clearColor().CGColor
        replicator.frame = view.bounds
        //configure the replicator
        replicator.instanceCount = 10
        
        var replyTransform = CATransform3DIdentity
        replyTransform = CATransform3DTranslate(replyTransform, 0, lineWidth/2.0, 0)
        replyTransform = CATransform3DRotate(replyTransform, CGFloat(M_PI)/5, 0, 0, 1.0)
        replyTransform = CATransform3DTranslate(replyTransform, 0, -lineWidth/2.0, 0)
        replicator.instanceTransform = replyTransform
        
        //apply a color shift for each instance
        replicator.instanceBlueOffset = -0.1
        replicator.instanceGreenOffset = -0.1
        
        let layer = CALayer()
        layer.frame = CGRect(x: view.right - lineWidth , y: view.centerY, width: lineWidth, height: lineWidth)
        layer.backgroundColor  = UIColor.randomColor().CGColor
        replicator.addSublayer(layer)
        
        view.layer.addSublayer(replicator)
        
        
        //image
        let butterflyImage = UIImage(named: "butterfly")!
        
        //ReflectionView
        let reflection = CAReplicatorLayer()
        reflection.backgroundColor = UIColor.redColor().CGColor
        reflection.instanceCount = 2
        reflection.frame = CGRect(x: 0, y: 0, width: butterflyImage.size.width, height: butterflyImage.size.height)
        reflection.position = CGPoint(x: view.centerX, y: view.centerY)
        reflection.instanceAlphaOffset = 0.5
        
        //transform
        var reflectionTransform = CATransform3DIdentity
        reflectionTransform = CATransform3DRotate(reflectionTransform, CGFloat(M_PI), 1, 0, 0)
        reflection.instanceTransform = reflectionTransform
        
        //sublayer
        let butterflyLayer = CALayer()
        butterflyLayer.contents = butterflyImage.CGImage
        butterflyLayer.frame = CGRect(x: 0, y: 0, width: butterflyImage.size.width / 2.0, height: butterflyImage.size.height / 2.0)
        butterflyLayer.position = CGPoint(x: butterflyImage.size.width / 2.0 , y: butterflyImage.size.height / 4.0)
        reflection.addSublayer(butterflyLayer)
        
        view.layer.addSublayer(reflection)
    }
    
    private func faceWithTransform(transfrom: CATransform3D, text: String) -> CALayer {
        let face = CAGradientLayer()
        face.frame = CGRect(x: -lineWidth, y: -lineWidth, width: lineWidth*2, height: lineWidth*2)
        
        //apply a color
        face.colors = [UIColor.randomColor().CGColor, UIColor.randomColor().CGColor,
                       UIColor.randomColor().CGColor, UIColor.randomColor().CGColor, UIColor.randomColor().CGColor]
        face.locations = [0, 0.25, 0.5, 0.75, 1]
        face.startPoint = CGPoint(x: 0, y: 0)
        face.endPoint = CGPoint(x: 1, y: 1)
        
        //textLayer
        let textLayer = CATextLayer()
        textLayer.frame = face.bounds
        textLayer.foregroundColor = UIColor.randomColor().CGColor
        textLayer.font = UIFont.boldSystemFontOfSize(13.0)
        textLayer.contentsScale = UIScreen.mainScreen().scale
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.string = text
        face.addSublayer(textLayer)
        
        //apply the transform
        face.transform = transfrom
        return face
    }
    
    private func cubeWithTransform(transform: CATransform3D) -> CALayer {
        let cube = CATransformLayer()
        //face1
        var ct = CATransform3DMakeTranslation(0, 0, lineWidth)
        cube.addSublayer(faceWithTransform(ct, text: String(1)))
        
        //face2
        ct = CATransform3DMakeTranslation(lineWidth, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct, text: String(2)))
        
        //face3
        ct = CATransform3DMakeTranslation(0, -lineWidth, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 1, 0, 0)
        cube.addSublayer(faceWithTransform(ct, text: String(3)))
        
        //face4
        ct = CATransform3DMakeTranslation(0, lineWidth, 0)
        ct = CATransform3DRotate(ct, -CGFloat(M_PI_2), 1, 0, 0)
        cube.addSublayer(faceWithTransform(ct, text: String(4)))
        
        //face5
        ct = CATransform3DMakeTranslation(-lineWidth, 0, 0)
        ct = CATransform3DRotate(ct, -CGFloat(M_PI_2), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct, text: String(5)))
        
        //face6
        ct = CATransform3DMakeTranslation(0, 0, -lineWidth)
        ct = CATransform3DRotate(ct, CGFloat(M_PI), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct, text: String(6)))
        
        cube.position = CGPoint(x: view.width / 2.0, y: 3*lineWidth)
        cube.transform = transform
        return cube
    }
}

//
//  EmitterLayerViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/18.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class EmitterLayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let emitter = CAEmitterLayer()
        let viewbouns = view.layer.bounds
        view.layer.addSublayer(emitter)
        
        //configure
        emitter.emitterPosition = CGPoint(x: viewbouns.size.width / 2, y: viewbouns.size.height)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterMode = kCAEmitterLayerVolume
        emitter.renderMode = kCAEmitterLayerAdditive
        
        //cell
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "DazFire")?.CGImage
        //粒子产生的频率
        cell.birthRate = 50.0
        //粒子存活的时间
        cell.lifetime = 10.0
        //粒子存活的范围
        cell.lifetimeRange = 10.0
        //粒子的颜色
        cell.color = UIColor.redColor().CGColor
        cell.alphaSpeed = 0.2
        //粒子的速度
        cell.velocity = 20.0
        //速度范围
        cell.velocityRange = 50.0
        //发散角度
        cell.emissionRange = CGFloat(M_PI) / 4
        
        emitter.emitterCells = [cell]
    }
    
}

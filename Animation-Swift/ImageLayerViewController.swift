//
//  ImageLayerViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/12.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class ImageLayerViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let subview = UIScrollView()
        subview.frame = self.view.frame
        self.view.addSubview(subview)
        return subview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let titlLayer = CATiledLayer()
        // 加入Scale显示高清图
        //        titlLayer.frame = CGRect(x: 0, y: 0, width: 1024, height: 1024)
        //        titlLayer.contentsScale = UIScreen.mainScreen().scale
        
        titlLayer.frame = CGRect(x: 0, y: 0, width: 2048, height: 2048)
        titlLayer.delegate = self
        
        scrollView.layer.addSublayer(titlLayer)
        scrollView.contentSize = titlLayer.frame.size
        
        titlLayer.setNeedsDisplay()
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        let tiledLayer = layer as! CATiledLayer
        let bounds = CGContextGetClipBoundingBox(ctx)
        // 加入Scale显示高清图
        //        let scale = UIScreen.mainScreen().scale
        //        let x = floor(bounds.origin.x / tiledLayer.tileSize.width * scale)
        //        let y = floor(bounds.origin.y / tiledLayer.tileSize.height * scale)
        
        let x = floor(bounds.origin.x / tiledLayer.tileSize.width)
        let y = floor(bounds.origin.y / tiledLayer.tileSize.height)
        
        let imageName = NSString(format:"homepage_%02d_%02d", Int(x), Int(y)) as String
        let imagePath = NSBundle.mainBundle().pathForResource(imageName, ofType: "jpg")
        if let tileImage = UIImage(contentsOfFile: imagePath!) {
            //draw
            UIGraphicsPushContext(ctx)
            tileImage.drawInRect(bounds)
            UIGraphicsPopContext()
        }
    }
}

//
//  DrawingView.swift
//  Animation-Swift
//
//  Created by sean on 16/5/21.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    let brushSize: CGFloat = 32.0
    
    var strokes = [NSValue]()
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var path: UIBezierPath = {
        let path = UIBezierPath()
        path.lineJoinStyle = CGLineJoin.Round
        path.lineCapStyle = CGLineCap.Round
        path.lineWidth = 3.0
        return path
    }()
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer: CAShapeLayer = self.layer as! CAShapeLayer
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        layer.lineWidth = 5.0
        return layer
    }()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //draw
        if let drawPoint = touches.first?.locationInView(self) {
            //            path.moveToPoint(drawPoint)
            addBrushStrokeAtPoint(drawPoint)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //draw
        if let drawPoint = touches.first?.locationInView(self) {
            //            path.addLineToPoint(drawPoint)
            //
            //            shapeLayer.path = path.CGPath
            addBrushStrokeAtPoint(drawPoint)
        }
    }
    
    override func drawRect(rect: CGRect) {
        for value in strokes {
            let point = value.CGPointValue()
            
            let brushRect = self.brushRect(point)
            
            if CGRectIntersectsRect(rect, brushRect) {
                UIImage(named: "Chalk")?.drawInRect(brushRect)
            }
        }
    }
    
    private func brushRect(point: CGPoint) -> CGRect {
        return CGRect(x: point.x - brushSize/2, y: point.y - brushSize/2.0, width: brushSize, height: brushSize)
    }
    
    private func addBrushStrokeAtPoint(point: CGPoint) {
        strokes.append(NSValue(CGPoint: point))
        
        //need draw
        setNeedsDisplayInRect(self.brushRect(point))
    }
}

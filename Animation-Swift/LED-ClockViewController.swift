//
//  LED-ClockViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/8.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class LED_ClockViewController: UIViewController {

    var digitViews = [UIView]()
    
    let viewWidth:  CGFloat = 50.0
    let viewHeight: CGFloat = 67.0
    var originY:    CGFloat {
        return self.view.centerY
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let digitImage = UIImage(named: "Digits")
        for index in 0...5 {
            let frame = CGRect(x: CGFloat(index)*viewWidth + 38.0, y: originY, width: viewWidth, height: viewHeight)
            
            let digitView = UIView()
            digitView.frame = frame
            
            digitView.layer.contents = digitImage?.CGImage
            digitView.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0)
            digitView.layer.contentsGravity = "resizeAspect"
            digitView.layer.magnificationFilter = "nearest"
            
            view.addSubview(digitView)
            digitViews.append(digitView)
        }
        
        let tickTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        tickTimer.fire()
    
        //组透明 无法实现
        let firstView = digitViews.first!
        firstView.layer.shouldRasterize = true
        firstView.layer.rasterizationScale = UIScreen.mainScreen().scale
        firstView.alpha = 0.5
    }
    
    func tick() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: NSDate())

        setDigit(components.hour / 10, forView: digitViews[0])
        setDigit(components.hour % 10, forView: digitViews[1])
        
        setDigit(components.minute / 10, forView: digitViews[2])
        setDigit(components.minute % 10, forView: digitViews[3])
        
        setDigit(components.second / 10, forView: digitViews[4])
        setDigit(components.second % 10, forView: digitViews[5])
    }
    
    private func setDigit(digit: Int, forView: UIView) {
        forView.layer.contentsRect = CGRectMake(CGFloat(digit) * 0.1, 0, 0.1, 1.0)
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

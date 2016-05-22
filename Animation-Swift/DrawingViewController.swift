//
//  DrawingViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/21.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        
        let drawingView = DrawingView()
        drawingView.frame = view.bounds
        view.addSubview(drawingView)
    }
    
}

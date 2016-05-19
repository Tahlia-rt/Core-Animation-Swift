//
//  PlayerLayerViewController.swift
//  Animation-Swift
//
//  Created by sean on 16/5/19.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerLayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let playUrl = NSBundle.mainBundle().URLForResource("colorfulStreak", withExtension: "m4v")
        
        let player = AVPlayer(URL: playUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        
        setupPlayer(playerLayer)
        
        player.play()
    }
    
    func setupPlayer(layer: AVPlayerLayer) {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 1, 1, 0)
        layer.transform = transform
        
        layer.masksToBounds = true
        layer.cornerRadius = 20.0
        layer.borderColor = UIColor.redColor().CGColor
        layer.borderWidth = 5.0
    }
}

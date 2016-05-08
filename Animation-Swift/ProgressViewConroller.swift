//
//  ProgressViewConroller.swift
//  Animation-Swift
//
//  Created by sean on 16/5/8.
//  Copyright © 2016年 sean. All rights reserved.
//

import UIKit

class ProgressViewConroller: UIViewController {

    var progress: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(backImageView)
        view.addSubview(progressIndicatorView);
        
        let url = NSURL(string: "http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg")
        backImageView.sd_setImageWithURL(url, placeholderImage: nil, options: .CacheMemoryOnly, progress: {
            [weak self] (receivedSize, expectedSize) in
                self!.progressIndicatorView.progress = CGFloat(receivedSize)/CGFloat(expectedSize)
            }) { [weak self] (image, error, _, _) in
                self!.progressIndicatorView.reveal()
        }
    }

    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    lazy var progressIndicatorView: CircularLoaderView = {
        let view = CircularLoaderView(frame: self.view.bounds)
        return view
    }()
}

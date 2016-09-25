//
//  ViewController.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit
import WatchKit_iOS

class ViewController: UIViewController {

    var watchStoryboard: WatchStoryboard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.watchStoryboard = WatchStoryboard(fileName: "WatchStoryboard", applicationNamespace: "Basic_Watch_App")
        
        guard let watchView = watchStoryboard?.watchView else { return }
        self.view.addSubview(watchView)
        watchView.frame.origin = CGPoint(x: 30, y: 30)
    }

}


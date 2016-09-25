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

    var watchController: WKInterfaceController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let watchStoryboard = WatchStoryboard(fileName: "WatchStoryboard", applicationNamespace: "Basic_Watch_App")
        watchController = watchStoryboard!.rootComponents[0] as! WKInterfaceController
        
        self.view.addSubview(watchController.view)
        watchController.view.frame.origin = CGPoint(x: 30, y: 30)
        
        
    }

}


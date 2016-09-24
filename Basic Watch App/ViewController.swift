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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let watchStoryboard = WatchStoryboard(fileName: "WatchStoryboard", applicationNamespace: "Basic_Watch_App")
        
        print(watchStoryboard?.rootComponents)
        
        
    }

}


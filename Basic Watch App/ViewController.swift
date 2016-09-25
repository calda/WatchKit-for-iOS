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
    @IBOutlet weak var watchContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.watchStoryboard = WatchStoryboard(fileName: "Interface", applicationNamespace: "Basic_Watch_App")
        
        guard let watchView = watchStoryboard?.watchView else { return }
        self.watchContainer.addSubview(watchView)
    }

}


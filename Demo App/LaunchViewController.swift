//
//  LaunchViewController.swift
//  Demo App
//
//  Created by Cal Stephens on 11/11/17.
//  Copyright © 2017 Cal Stephens. All rights reserved.
//

import UIKit
import WatchKit_iOS

class LaunchViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let watchVC = WatchContainerViewController.create(withInterfaceFileNamed: "Interface", inNamespace: "Demo App")
        present(watchVC, animated: false, completion: nil)
        
        watchVC.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            watchVC.view.alpha = 1.0
        })
    }
    
}

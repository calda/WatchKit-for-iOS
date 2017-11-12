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
        watchVC.modalPresentationStyle = .overFullScreen
        watchVC.modalTransitionStyle = .crossDissolve
        present(watchVC, animated: true, completion: nil)
    }
    
}

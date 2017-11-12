//
//  WatchContainerViewController.swift
//  Demo App
//
//  Created by Cal Stephens on 11/11/17.
//  Copyright © 2017 Cal Stephens. All rights reserved.
//

import UIKit

public class WatchContainerViewController: UIViewController {
    
    var interfaceFileName: String!
    var applicationNamespace: String!
    
    // MARK: Presentation
    
    public static func create(
        withInterfaceFileNamed interfaceFileName: String,
        inNamespace applicationNamespace: String) -> WatchContainerViewController
    {
        let storyboard = UIStoryboard(name: "WatchContainer", bundle: Bundle(for: WatchContainerViewController.self))
        let containerViewController = storyboard.instantiateInitialViewController() as! WatchContainerViewController
        containerViewController.interfaceFileName = interfaceFileName
        containerViewController.applicationNamespace = applicationNamespace.replacingOccurrences(of: " ", with: "_")
        return containerViewController
    }
    
    // MARK: Setup
    
    var watchStoryboard: WatchStoryboard!
    @IBOutlet weak var watchContainer: UIView!
    @IBOutlet weak var menuItemStackView: UIStackView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.watchStoryboard = WatchStoryboard(fileName: interfaceFileName, applicationNamespace: applicationNamespace)
        self.watchStoryboard.delegate = self
        
        guard let watchView = watchStoryboard?.watchView else { return }
        self.watchContainer.addSubview(watchView)
    }
    
    // MARK: User Interaction
    
    private func updateStackView(with menuItems: [WatchStoryboardMenuItem]) {
        menuItemStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}

// MARK: WatchStoryboardDelegate

extension WatchContainerViewController: WatchStoryboardDelegate {
    
    public func storyboard(
        _ storyboard: WatchStoryboard,
        didUpdateForceTouchOptionsTo forceTouchOptions: [WatchStoryboardMenuItem])
    {
        print(forceTouchOptions)
    }
    
}

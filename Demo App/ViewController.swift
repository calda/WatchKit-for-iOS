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
        
        self.watchStoryboard = WatchStoryboard(fileName: "Interface", applicationNamespace: "Demo_App")
        
        guard let watchView = watchStoryboard?.watchView else { return }
        self.watchContainer.addSubview(watchView)
    }
    
    @IBAction func simulateForceTouch(_ sender: AnyObject) {
        if let menuItems = watchStoryboard.currentController?.menuItems {
            
            let message = menuItems.count == 0 ? "No actions available on this screen" : "Select an action"
            
            let alert = UIAlertController(title: "Force Touch", message: message, preferredStyle: .alert)
            
            for menuItem in menuItems {
                let action = UIAlertAction(title: menuItem.title ?? "Unnamed Action", style: .default, handler: { _ in
                    menuItem.actions.forEach { action in
                        
                        if let selectorName = action.selectorName {
                            let sel = Selector(selectorName)
                            let _ = self.watchStoryboard.currentController?.perform(sel)
                        }
                    }
                })
                
                alert.addAction(action)
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }

}


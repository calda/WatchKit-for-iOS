//
//  InterfaceController.swift
//  Basic Watch App WatchKit Extension
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

//import WatchKit
import Foundation
import WatchKit_iOS


class InterfaceController: WKInterfaceController {

    /*override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }*/

    @IBAction func pushPressed() {
        print("PUSH")
    }
}

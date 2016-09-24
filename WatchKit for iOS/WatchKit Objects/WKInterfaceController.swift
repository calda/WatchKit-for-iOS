//
//  WKInterfaceController.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WKInterfaceController : WatchComponent {
    
    let identifier: String?
    let title: String?
    let customClassName: String?
    
    override init(type: String, properties: [String : String]) {
        self.identifier = "identifier" <- properties
        self.title = "title" <- properties
        self.customClassName = "customClass" <- properties
        
        super.init(type: type, properties: properties)
    }
    
}

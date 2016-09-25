//
//  WatchStoryboardColor.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WatchStoryboardColor : WatchComponent {
    
    let color: UIColor?
    let key: String
    
    required init(type: String, properties: [String : String]) {
        self.key = ("key" <- properties) ?? "<unknown key>"
        
        let red: CGFloat? = "red" <- properties
        let green: CGFloat? = "green" <- properties
        let blue: CGFloat? = "blue" <- properties
        let alpha: CGFloat? = "alpha" <- properties
        
        if let red = red, let green = green, let blue = blue {
            self.color = UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1.0)
        } else {
            self.color = nil
        }
        
        super.init(type: type, properties: properties)
    }
    
}

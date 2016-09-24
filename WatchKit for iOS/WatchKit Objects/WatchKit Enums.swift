//
//  WKInterfaceHorizontalAlignment.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

enum WKInterfaceObjectHorizontalAlignment {
    case left, center, right
    
    static func fromString(string: String?) -> WKInterfaceObjectHorizontalAlignment {
        if string?.lowercased() == "center" { return .center }
        if string?.lowercased() == "right" { return .right }
        return .left
    }
    
}

enum WKInterfaceObjectVerticalAlignment {
    case top, center, bottom
    
    static func fromString(string: String?) -> WKInterfaceObjectVerticalAlignment {
        if string?.lowercased() == "center" { return .center }
        if string?.lowercased() == "bottom" { return .bottom }
        return .top
    }
    
}

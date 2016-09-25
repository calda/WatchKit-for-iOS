//
//  WKInterfaceHorizontalAlignment.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

enum WKInterfaceObjectHorizontalAlignment {
    case left, center, right
    
    static func fromString(string: String?) -> WKInterfaceObjectHorizontalAlignment {
        let lowercase = string?.lowercased()
        if lowercase == "center" { return .center }
        if lowercase == "right" { return .right }
        return .left
    }
    
}

enum WKInterfaceObjectVerticalAlignment {
    case top, center, bottom
    
    static func fromString(string: String?) -> WKInterfaceObjectVerticalAlignment {
        let lowercase = string?.lowercased()
        if lowercase == "center" { return .center }
        if lowercase == "bottom" { return .bottom }
        return .top
    }
    
}

@objc enum WKInterfaceLayoutDirection: Int {
    case vertical, horizontal
}

extension NSTextAlignment {
    
    static func fromString(string: String?) -> NSTextAlignment {
        let lowercase = string?.lowercased()
        if lowercase == "left" { return .left }
        if lowercase == "right" { return .right }
        if lowercase == "center" { return .center }
        if lowercase == "justified" { return .justified }
        return .natural
    }
    
}



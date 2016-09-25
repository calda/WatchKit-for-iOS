//
//  Length.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

enum Length {
    
    case relative(percentage: CGFloat)
    case absolute(CGFloat)
    
    var numberValue: CGFloat {
        switch self {
            case let .relative(percentage): return percentage
            case let .absolute(length): return length
        }
    }
    
    static func from(float: CGFloat) -> Length? {
        if float < 0 { return nil }
        if float <= 1.0 { return relative(percentage: float) }
        else { return absolute(float) }
    }
    
    func length(in superlength: CGFloat) -> CGFloat {
        switch self {
            case let .relative(percentage): return percentage * superlength
            case let .absolute(length): return length
        }
    }
    
}

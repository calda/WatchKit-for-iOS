//
//  Operators.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

precedencegroup XML {
    higherThan: AssignmentPrecedence
}

infix operator <- : XML


//MARK: - Primatives

func <-(key: String, dict: [String : String]) -> String? {
    return dict[key]
}

func <-(key: String, dict: [String : String]) -> Double? {
    guard let string: String = key <- dict else { return nil }
    return Double(string)
}

func <-(key: String, dict: [String : String]) -> CGFloat? {
    guard let double: Double = key <- dict else { return nil }
    return CGFloat(double)
}

func <-(key: String, dict: [String : String]) -> Int? {
    guard let string = dict[key] else { return nil }
    return Int(string)
}

func <-(key: String, dict: [String : String]) -> Bool {
    guard let string = dict[key] else { return false }
    return string == "YES"
}


//MARK: - Objects

func <-(key: String, dict: [String : String]) -> Length? {
    guard let cgFloat: CGFloat = key <- dict else { return nil }
    return Length.from(float: cgFloat)
}

func <-(key: String, dict: [String : String]) -> NSTextAlignment {
    return NSTextAlignment.fromString(string: key <- dict)
}

func <-(key: String, dict: [String : String]) -> WKInterfaceObjectVerticalAlignment {
    return WKInterfaceObjectVerticalAlignment.fromString(string: key <- dict)
}

func <-(key: String, dict: [String : String]) -> WKInterfaceObjectHorizontalAlignment {
    return WKInterfaceObjectHorizontalAlignment.fromString(string: key <- dict)
}

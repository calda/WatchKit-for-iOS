//
//  Operators.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

precedencegroup XML {
    higherThan: AssignmentPrecedence
}

infix operator <- : XML

func <-(key: String, dict: [String : String]) -> String? {
    return dict[key]
}

func <-(key: String, dict: [String : String]) -> Double? {
    guard let string = dict[key] else { return nil }
    return Double(string)
}

func <-(key: String, dict: [String : String]) -> Int? {
    guard let string = dict[key] else { return nil }
    return Int(string)
}

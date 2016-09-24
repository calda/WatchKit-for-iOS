//
//  Stack.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

///Standard Stack data structure

struct Stack<T> {
    
    var array : [T] = []
    
    mutating func push(push: T) {
        array.append(push)
    }
    
    @discardableResult mutating func pop() -> T? {
        if array.count == 0 { return nil }
        let count = array.count
        let pop = array[count - 1]
        array.removeLast()
        return pop
    }
    
    var top: T? {
        if array.count == 0 { return nil }
        return array[count - 1]
    }
    
    var count: Int {
        return array.count
    }
    
}

//
//  WatchComponent.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

let WKiOS_SUPPORTED_COMPONENTS: [String : WatchComponent.Type] = [
    "controller" : WKInterfaceController.self,
    "group" : WKInterfaceGroup.self
]

class WatchComponent : CustomStringConvertible {
    
    //MARK: - static helper
    
    static func create(type: String, properties: [String : String]) -> WatchComponent? {
        if let type = WKiOS_SUPPORTED_COMPONENTS[type] {
            //instantiate somehow
        }
            
        else { return nil }
        
    }
    
    
    //MARK: - instance variables
    
    var type: String
    var properties: [String : String]
    
    var children: [WatchComponent]?
    
    var description: String {
        return type
    }
    
    func addChild(_ child: WatchComponent) {
        if children == nil {
            children = []
        }
        
        children?.append(child)
    }
    
    init(type: String, properties: [String : String]) {
        self.type = type
        self.properties = properties
    }
    
    
    //MARK: - override points

}

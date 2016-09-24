//
//  WatchComponent.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

typealias ComponentInitializer = (_ type: String, _ properties: [String : String]) -> WatchComponent

let WKiOS_SUPPORTED_COMPONENTS: [String : ComponentInitializer] = [
    "controller" : WKInterfaceController.init,
    "group" : WKInterfaceGroup.init
]


class WatchComponent {
    
    //MARK: - static helper
    
    static func create(type: String, properties: [String : String]) -> WatchComponent? {
        if let initializer = WKiOS_SUPPORTED_COMPONENTS[type] {
            return initializer(type, properties)
        } else { return nil }
    }
    
    
    //MARK: - instance variables
    
    let id: String
    let type: String
    let properties: [String : String]
    
    var children: [WatchComponent]?
    
    
    init(type: String, properties: [String : String]) {
        self.type = type
        self.properties = properties
        self.id = properties["id"] ?? "<unknown id>"
    }
    
    func addChild(_ child: WatchComponent) {
        if children == nil {
            children = []
        }
        
        children?.append(child)
    }

}

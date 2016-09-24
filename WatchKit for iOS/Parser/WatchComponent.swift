//
//  WatchComponent.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation

open class WatchComponent {
    
    //MARK: - static helper
    
    static func create(type: String, properties: [String : String], namespace: String) -> WatchComponent? {
        
        guard var componentClass = WKiOS_SUPPORTED_COMPONENTS[type] else {
            return nil
        }
        
        if let customClassName: String = ("customClass") <- properties {
            
            let classString = "\(namespace).\(customClassName)"
            guard let customClass: AnyClass = NSClassFromString(classString) else {
                print("Unable to dynamically load class of type \(classString)")
                return nil
            }
            
            guard let objectClass = customClass as? WatchComponent.Type else {
                print("\(classString) is not a subclass of WKiOS WatchComponent")
                return nil
            }
            
            componentClass = objectClass
        }
        
        print(componentClass)
        return componentClass.init(type: type, properties: properties)
    }
    
    
    //MARK: - instance variables
    
    let id: String?
    let type: String
    let properties: [String : String]
    
    var children: [WatchComponent]?
    
    
    required public init(type: String, properties: [String : String]) {
        self.type = type
        self.properties = properties
        self.id = properties["id"]
    }
    
    func addChild(_ child: WatchComponent) {
        if children == nil {
            children = []
        }
        
        children?.append(child)
    }
    
    ///called when all of the object's children have been loaded
    func doneLoadingChildren() {
        //override for special behavior
    }

}

//
//  WatchStoryboardOutlet.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation

class WatchStoryboardOutlet : WatchComponent {
    
    var propertyName: String?
    var viewId: String?
    
    public required init(type: String, properties: [String : String]) {
        self.propertyName = "property" <- properties
        self.viewId = "destination" <- properties
        
        super.init(type: type, properties: properties)
    }
    
    func connectToView(in controller: WKInterfaceController) {
        guard let propertyName = self.propertyName else { return }
        guard let viewId = self.viewId else { return }
        
        var viewWithId: WKInterfaceObject? = nil
        
        func searchSubviews(_ subviews: [WKInterfaceObject]) -> Bool {
            for subview in subviews {
                if compare(subview: subview) {
                    return true
                }
            }
            
            return false
        }
        
        func compare(subview: WKInterfaceObject) -> Bool {
            if subview.id == viewId {
                viewWithId = subview
                return true
            } else if let group = subview as? WKInterfaceGroup {
                return searchSubviews(group.subviews)
            }
        
            return false
        }
        
        let subviews = controller.children?.flatMap { $0 as? WKInterfaceObject } ?? []
        let _ = searchSubviews(subviews)
        
        if let viewToConnect = viewWithId {
            controller.setValue(viewToConnect, forKey: propertyName)
        }
        
        
    }
    
}

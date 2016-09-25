//
//  WatchStoryboardMenuItem.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WatchStoryboardMenuItem : WatchComponent {
    
    public var title: String?
    var iconName: String?
    
    var icon: UIImage? {
        return UIImage(named: self.iconName ?? "menuItem-default")
    }
    
    public var actions: [WatchStoryboardAction] {
        return self.children?.flatMap { $0 as? WatchStoryboardAction } ?? []
    }
    
    public required init(type: String, properties: [String : String]) {
        self.title = "title" <- properties
        self.iconName = "iconName" <- properties
        
        super.init(type: type, properties: properties)
    }
    
}

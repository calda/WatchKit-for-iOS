//
//  WKInterfaceController.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WKInterfaceController : WatchComponent {
    
    let identifier: String?
    let title: String?
    let customClassName: String?
    
    public var view: UIScrollView
    
    required public init(type: String, properties: [String : String]) {
        self.identifier = "identifier" <- properties
        self.title = "title" <- properties
        self.customClassName = "customClass" <- properties
        
        let viewBounds = CGRect(x: 0, y: 0, width: 156, height: 195)
        view = UIScrollView(frame: viewBounds)
        view.backgroundColor = UIColor.black
        
        super.init(type: type, properties: properties)
    }
    
    override func addChild(_ child: WatchComponent) {
        if let interfaceObject = child as? WKInterfaceObject, let backingView = interfaceObject.backingView {
            view.addSubview(backingView)
        }
        
        super.addChild(child)
    }
    
}

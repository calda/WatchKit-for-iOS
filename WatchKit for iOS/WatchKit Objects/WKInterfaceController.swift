//
//  WKInterfaceController.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WKInterfaceController : WatchComponent, WatchLayoutDelegate {
    
    let identifier: String?
    let title: String?
    let customClassName: String?
    
    public var view: WatchLayoutView
    let spacing: CGFloat
    
    required public init(type: String, properties: [String : String]) {
        self.identifier = "identifier" <- properties
        self.title = "title" <- properties
        self.customClassName = "customClass" <- properties
        self.spacing = ("spacing" <- properties) ?? 4.0
        
        let viewBounds = CGRect(x: 0, y: 0, width: 156, height: 195)
        view = WatchLayoutView(frame: viewBounds)
        view.backgroundColor = UIColor.black
        
        super.init(type: type, properties: properties)
        
        view.delegate = self
    }
    
    override func addChild(_ child: WatchComponent) {
        if let interfaceObject = child as? WKInterfaceObject, let backingView = interfaceObject.backingView {
            view.addSubview(backingView)
        }
        
        super.addChild(child)
    }
    
    
    //MARK: - Watch Layout Delegate
    
    func watchLayoutSpacing() -> CGFloat {
        return self.spacing
    }
    
    func watchLayoutChildrenComponents() -> [AnyObject] {
        return self.children ?? []
    }
    
    func watchLayoutDirection() -> WKInterfaceLayoutDirection {
        return .vertical
    }
    
}

//
//  WKInterfaceGroup.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

public class WKInterfaceGroup : WKInterfaceObject, WatchLayoutDelegate {
    
    
    //MARK: - Properties
    
    var spacing: CGFloat
    
    var subviews: [WKInterfaceObject] {
        return self.children?.flatMap{ $0 as? WKInterfaceObject } ?? []
    }
    
    override var intrinsicHeightValue: Length? {
        let heights = self.subviews.flatMap{ interfaceObject -> CGFloat? in
            guard let height = interfaceObject.heightValue ?? interfaceObject.intrinsicHeightValue else { return nil }
            switch height {
                case let .absolute(size): return size
                default: return nil
            }
        }
        
        let largestHeight = heights.reduce(0, max)
        return .absolute(largestHeight)
    }
    
    
    //MARK: - Set up
    
    required public init(type: String, properties: [String : String]) {
        self.spacing = ("spacing" <- properties) ?? 4.0
            
        super.init(type: type, properties: properties)
        
        self.backingView = WatchLayoutView()
        (self.backingView as? WatchLayoutView)?.delegate = self
    }
    
    public override func view() -> WatchLayoutView? {
        return self.backingView as? WatchLayoutView
    }
    
    override func addChild(_ child: WatchComponent) {
        if let interfaceObject = child as? WKInterfaceObject {
            interfaceObject.controller = self.controller
            
            if let backingView = interfaceObject.backingView {
                view()?.addSubview(backingView)
            }
        }
        
        super.addChild(child)
    }
    
    
    //MARK: - WatchLayoutDelegate
    
    func watchLayoutDirection() -> WKInterfaceLayoutDirection {
        return .horizontal
    }
    
    func watchLayoutSpacing() -> CGFloat {
        return self.spacing
    }
    
    func watchLayoutChildrenComponents() -> [AnyObject] {
        return self.children ?? []
    }
    
}

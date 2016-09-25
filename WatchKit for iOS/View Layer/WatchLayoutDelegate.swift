//
//  WatchLayoutViewDelegate.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

@objc protocol WatchLayoutDelegate: class {

    func watchLayoutDirection() -> WKInterfaceLayoutDirection
    
    @objc optional func watchLayoutSpacing() -> CGFloat
    @objc optional func watchLayoutChildrenComponents() -> [AnyObject]
    
    @objc optional func watchLayoutPadding() -> CGFloat
    @objc optional func watchLayoutSetsOwnFrameHeight() -> Bool
    
}


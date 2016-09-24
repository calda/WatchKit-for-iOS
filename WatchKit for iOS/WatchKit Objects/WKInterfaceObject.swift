//
//  WKInterfaceObject.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation
import UIKit

open class WKInterfaceObject<T : UIView> : WatchComponent {
    
    var backingView: T?
    
    var alpha: CGFloat { didSet { backingView?.alpha = alpha } }
    var hidden: Bool { didSet { backingView?.isHidden = hidden } }
    
    var horizontalAlignment: WKInterfaceObjectHorizontalAlignment
    var verticalAlignment: WKInterfaceObjectVerticalAlignment
    
    var specifiedWidth: CGFloat?
    var specifiedHeight: CGFloat?
    
    var intrinsicHeight: CGFloat? {
        return nil
    }
    
    var calculatedFrame: CGRect = .zero {
        didSet {
            self.backingView?.frame = calculatedFrame
        }
    }
    
    required public init(type: String, properties: [String : String]) {
        self.alpha = ("alpha" <- properties) ?? 1.0
        self.hidden = "hidden" <- properties
        
        self.horizontalAlignment = "alignment" <- properties
        self.verticalAlignment = "verticalAlignment" <- properties
        
        self.specifiedWidth = "width" <- properties
        self.specifiedHeight = "height" <- properties
        
        super.init(type: type, properties: properties)
    }
    
    
    //MARK: - WatchKit methods
    
    func setAlpha(_ alpha: CGFloat) {
        self.alpha = alpha
    }
    
    func setHidden(_ hidden: Bool) {
        self.hidden = hidden
    }
    
    func setWidth(_ width: CGFloat) {
        self.specifiedHeight = width
    }
    
    func setRelativeWidth(_ width: CGFloat, withAdjstment: CGFloat) {
        self.specifiedWidth = width
    }
    
    func setHeight(_ height: CGFloat) {
        self.specifiedHeight = height
    }
    
    func setRelativeHeight(_ height: CGFloat, withAdjstment: CGFloat) {
        self.specifiedHeight = height
    }
    
}

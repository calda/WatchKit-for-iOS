//
//  WKInterfaceObject.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation
import UIKit

open class WKInterfaceObject : WatchComponent, UIViewBacked {
    
    var backingView: UIView?
    weak var controller: WKInterfaceController?
    
    var alpha: CGFloat { didSet { view()?.alpha = alpha } }
    var hidden: Bool { didSet { view()?.isHidden = hidden } }
    
    var horizontalAlignment: WKInterfaceObjectHorizontalAlignment
    var verticalAlignment: WKInterfaceObjectVerticalAlignment
    
    var height: Length?
    var width: Length?
    
    var intrinsicHeight: Length? {
        return nil
    }
    
    var intrinsicWidth: Length? {
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
        
        self.width = "width" <- properties
        self.height = "height" <- properties
        
        super.init(type: type, properties: properties)
    }
    
    func applyPropertiesToView() {
        view()?.alpha = alpha
        view()?.isHidden = hidden
    }
    
    public func view() -> UIView? {
        return backingView
    }
    
    
    //MARK: - WatchKit methods
    
    func setAlpha(_ alpha: CGFloat) {
        self.alpha = alpha
    }
    
    func setHidden(_ hidden: Bool) {
        self.hidden = hidden
    }
    
    func setWidth(_ width: CGFloat) {
        self.width = Length.absolute(width)
    }
    
    func setRelativeWidth(_ width: CGFloat, withAdjstment: CGFloat = 0) {
        self.width = Length.relative(percentage: width)
    }
    
    func setHeight(_ height: CGFloat) {
        self.height = Length.absolute(height)
    }
    
    func setRelativeHeight(_ height: CGFloat, withAdjstment: CGFloat = 0) {
        self.height = Length.relative(percentage: height)
    }
    
}

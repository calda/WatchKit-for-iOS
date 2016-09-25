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
    
    var alphaValue: CGFloat { didSet { view()?.alpha = alphaValue } }
    var hiddenValue: Bool { didSet { view()?.isHidden = hiddenValue } }
    
    var horizontalAlignmentValue: WKInterfaceObjectHorizontalAlignment
    var verticalAlignmentValue: WKInterfaceObjectVerticalAlignment
    
    var heightValue: Length?
    var widthValue: Length?
    
    var intrinsicHeightValue: Length? {
        return nil
    }
    
    var intrinsicWidthValue: Length? {
        return nil
    }
    
    var calculatedFrame: CGRect = .zero {
        didSet {
            self.backingView?.frame = calculatedFrame
        }
    }
    
    required public init(type: String, properties: [String : String]) {
        self.alphaValue = ("alpha" <- properties) ?? 1.0
        self.hiddenValue = "hidden" <- properties
        
        self.horizontalAlignmentValue = "alignment" <- properties
        self.verticalAlignmentValue = "verticalAlignment" <- properties
        
        self.widthValue = "width" <- properties
        self.heightValue = "height" <- properties
        
        super.init(type: type, properties: properties)
    }
    
    func applyPropertiesToView() {
        view()?.alpha = alphaValue
        view()?.isHidden = hiddenValue
    }
    
    public func view() -> UIView? {
        return backingView
    }
    
    
    //MARK: - WatchKit methods
    
    func setAlpha(_ alpha: CGFloat) {
        self.alphaValue = alpha
    }
    
    func setHidden(_ hidden: Bool) {
        self.hiddenValue = hidden
    }
    
    func setWidth(_ width: CGFloat) {
        self.widthValue = Length.absolute(width)
    }
    
    func setRelativeWidth(_ width: CGFloat, withAdjstment: CGFloat = 0) {
        self.widthValue = Length.relative(percentage: width)
    }
    
    func setHeight(_ height: CGFloat) {
        self.heightValue = Length.absolute(height)
    }
    
    func setRelativeHeight(_ height: CGFloat, withAdjstment: CGFloat = 0) {
        self.heightValue = Length.relative(percentage: height)
    }
    
}

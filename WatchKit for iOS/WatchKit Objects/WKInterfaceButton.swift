//
//  WKInterfaceButton.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WKInterfaceButton : WKInterfaceObjectWithText {
    
    var titleValue: String? { didSet { self.view()?.setTitle(titleValue, for: .normal) } }
    var titleColorValue: UIColor? { didSet { self.view()?.setTitleColor(titleColorValue, for: .normal) } }
    var titleFontValue: UIFont? { didSet { self.view()?.titleLabel?.font = titleFontValue } }
    var backgroundColorValue: UIColor? { didSet { self.view()?.backgroundColor = backgroundColorValue } }
    
    var segue: WatchStoryboardSegue? = nil
    
    required public init(type: String, properties: [String : String]) {
        titleValue = "title" <- properties
        
        super.init(type: type, properties: properties)
        
        self.backingView = UIButton()
        self.view()?.addTarget(self, action: #selector(self.buttonPressed), for: .primaryActionTriggered)
        self.backingView?.layer.cornerRadius = 5.0
        
        doneLoadingChildren()
        applyPropertiesToView()
    }
    
    override func applyPropertiesToView() {
        super.applyPropertiesToView()
        
        view()?.setTitle(self.titleValue, for: .normal)
        view()?.setTitleColor(self.titleColorValue, for: .normal)
        view()?.titleLabel?.font = self.titleFontValue
        view()?.backgroundColor = self.backgroundColorValue
    }
    
    override public func view() -> UIButton? {
        return backingView as? UIButton
    }
    
    override func doneLoadingChildren() {
        let colors = children?.flatMap { $0 as? WatchStoryboardColor }
        if let titleColor = colors?.filter({ $0.key == "titleColor" }).first?.color {
            self.titleColorValue = titleColor
        } else if self.titleColorValue == nil {
            self.titleColorValue = UIColor.white
        }
        
        if let backgroundColor = colors?.filter({ $0.key == "backgroundColor" }).first?.color {
            self.backgroundColorValue = backgroundColor
        } else if self.backgroundColorValue == nil {
            self.backgroundColorValue = UIColor(white: 0.15, alpha: 1.0)
        }
        
        let fonts = children?.flatMap { $0 as? WatchStoryboardFont }
        if let titleFont = fonts?.first?.font {
            self.titleFontValue = titleFont
        }
        
        let actions = children?.flatMap { $0 as? WatchStoryboardAction } ?? []
        actions.forEach { action in
            action.applySelector(from: view(), to: self.controller)
        }
        
        let segues = children?.flatMap { $0 as? WatchStoryboardSegue } ?? []
        self.segue = segues.first
        
    }
    
    
    //MARK: - User Interaction
    
    @objc func buttonPressed() {
        guard let segue = self.segue else { return }
        guard let destinationId = segue.destinationId else { return }
        
        if segue.presentationStyle == .push {
            self.controller?.pushController(withId: destinationId, context: nil)
        } else {
            self.controller?.presentController(withId: destinationId, context: nil)
        }
    }
    
    
    //MARK: - WKInterfaceObjectWithText
    
    override func textForIntrinsicSizeCalulation() -> String? {
        return self.titleValue
    }
    
    override func fontForIntrinsicSizeCalulation() -> UIFont? {
        return self.titleFontValue
    }
    
    override func paddingForIntrinsicSizeCalculation() -> CGFloat? {
        return 10.0
    }
    
    
    //MARK: - WatchKit methods
    
    public func setTitle(_ title: String?) {
        self.titleValue = title
    }
    
    public func setBackgroundColor(_ color: UIColor?) {
        self.backgroundColorValue = color
    }
    
}

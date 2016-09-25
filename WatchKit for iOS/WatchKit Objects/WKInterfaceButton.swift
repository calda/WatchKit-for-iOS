//
//  WKInterfaceButton.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WKInterfaceButton : WKInterfaceObjectWithText {
    
    var title: String? { didSet { self.view()?.setTitle(title, for: .normal) } }
    var titleColor: UIColor? { didSet { self.view()?.tintColor = titleColor } }
    var titleFont: UIFont? { didSet { self.view()?.titleLabel?.font = titleFont } }
    
    var backgroundColor: UIColor? { didSet { self.view()?.backgroundColor = backgroundColor } }
    
    required public init(type: String, properties: [String : String]) {
        title = "title" <- properties
        
        super.init(type: type, properties: properties)
        
        self.backingView = UIButton()
        self.backingView?.layer.cornerRadius = 5.0
        
        doneLoadingChildren()
        applyPropertiesToView()
    }
    
    override func applyPropertiesToView() {
        super.applyPropertiesToView()
        
        view()?.setTitle(self.title, for: .normal)
        view()?.tintColor = self.titleColor
        view()?.titleLabel?.font = self.titleFont
        view()?.backgroundColor = self.backgroundColor
    }
    
    override func view() -> UIButton? {
        return backingView as? UIButton
    }
    
    override func doneLoadingChildren() {
        let colors = children?.flatMap { $0 as? WatchStoryboardColor }
        if let titleColor = colors?.filter({ $0.key == "titleColor" }).first?.color {
            self.titleColor = titleColor
        } else if self.titleColor == nil {
            self.titleColor = UIColor.white
        }
        
        if let backgroundColor = colors?.filter({ $0.key == "backgroundColor" }).first?.color {
            self.backgroundColor = backgroundColor
        } else if self.backgroundColor == nil {
            self.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        }
        
        let fonts = children?.flatMap { $0 as? WatchStoryboardFont }
        if let titleFont = fonts?.first?.font {
            self.titleFont = titleFont
        }
        
        let actions = children?.flatMap { $0 as? WatchStoryboardAction } ?? []
        actions.forEach { action in
            action.applySelector(from: view(), to: self.controller)
        }
        
    }
    
    
    //MARK: - WKInterfaceObjectWithText
    
    override func textForIntrinsicSizeCalulation() -> String? {
        return self.title
    }
    
    override func fontForIntrinsicSizeCalulation() -> UIFont? {
        return self.titleFont
    }
    
    override func paddingForIntrinsicSizeCalculation() -> CGFloat? {
        return 10.0
    }
    
    
    
    
}

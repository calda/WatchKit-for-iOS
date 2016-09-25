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
    var titleColor: UIColor? { didSet { self.view()?.setTitleColor(titleColor, for: .normal) } }
    var titleFont: UIFont? { didSet { self.view()?.titleLabel?.font = titleFont } }
    var backgroundColor: UIColor? { didSet { self.view()?.backgroundColor = backgroundColor } }
    
    var segue: WatchStoryboardSegue? = nil
    
    required public init(type: String, properties: [String : String]) {
        title = "title" <- properties
        
        super.init(type: type, properties: properties)
        
        self.backingView = UIButton()
        self.view()?.addTarget(self, action: #selector(self.buttonPressed), for: .primaryActionTriggered)
        self.backingView?.layer.cornerRadius = 5.0
        
        doneLoadingChildren()
        applyPropertiesToView()
    }
    
    override func applyPropertiesToView() {
        super.applyPropertiesToView()
        
        view()?.setTitle(self.title, for: .normal)
        view()?.setTitleColor(self.titleColor, for: .normal)
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
        return self.title
    }
    
    override func fontForIntrinsicSizeCalulation() -> UIFont? {
        return self.titleFont
    }
    
    override func paddingForIntrinsicSizeCalculation() -> CGFloat? {
        return 10.0
    }
    
}

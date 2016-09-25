//
//  WKInterfaceLabel.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WKInterfaceLabel : WKInterfaceObjectWithText {
    
    var textValue: String? { didSet { view()?.text = textValue } }
    var attributedTextValue: NSAttributedString? { didSet { view()?.attributedText = attributedTextValue } }
    
    var colorValue: UIColor { didSet { view()?.textColor = colorValue } }
    var textAlignmentValue: NSTextAlignment { didSet { view()?.textAlignment = textAlignmentValue } }
    var fontValue: UIFont { didSet { view()?.font = fontValue } }
    
    
    //MARK: - Set up
    
    required public init(type: String, properties: [String : String]) {
        textValue = "text" <- properties
        colorValue = UIColor.white
        fontValue = WKFontStyle.body.font
        textAlignmentValue = "textAlignment" <- properties
        
        super.init(type: type, properties: properties)
        
        backingView = UILabel()
        applyPropertiesToView()
    }
    
    override func applyPropertiesToView() {
        super.applyPropertiesToView()
        
        view()?.font = UIFont.systemFont(ofSize: 16.0)
        view()?.text = textValue
        view()?.textColor = colorValue
        view()?.textAlignment = textAlignmentValue
        view()?.numberOfLines = 0
    }
    
    override func doneLoadingChildren() {
        let colors = children?.flatMap { $0 as? WatchStoryboardColor }
        if let color = colors?.first?.color {
            self.colorValue = color
        }
        
        let fonts = children?.flatMap { $0 as? WatchStoryboardFont }
        if let font = fonts?.first?.font {
            self.fontValue = font
        }
        
        children = nil
    }
    
    override public func view() -> UILabel? {
        return self.backingView as? UILabel
    }
    
    
    //MARK: - WKInterfaceObjectWithText
    
    override func textForIntrinsicSizeCalulation() -> String? {
        return self.textValue
    }
    
    override func fontForIntrinsicSizeCalulation() -> UIFont? {
        return self.fontValue
    }
    
    
    //MARK: - WatchKit functions
    
    public func setText(_ text: String?) {
        self.textValue = text
    }
    
}

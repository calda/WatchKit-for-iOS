//
//  WKInterfaceLabel.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WKInterfaceLabel : WKInterfaceObjectWithText {
    
    var text: String? { didSet { view()?.text = text } }
    var attributedText: NSAttributedString? { didSet { view()?.attributedText = attributedText } }
    
    var color: UIColor { didSet { view()?.textColor = color } }
    var textAlignment: NSTextAlignment { didSet { view()?.textAlignment = textAlignment } }
    var font: UIFont { didSet { view()?.font = font } }
    
    
    //MARK: - Set up
    
    required public init(type: String, properties: [String : String]) {
        text = "text" <- properties
        color = UIColor.white
        font = WKFontStyle.body.font
        textAlignment = "textAlignment" <- properties
        
        super.init(type: type, properties: properties)
        
        backingView = UILabel()
        applyPropertiesToView()
    }
    
    override func applyPropertiesToView() {
        super.applyPropertiesToView()
        
        view()?.font = UIFont.systemFont(ofSize: 16.0)
        view()?.text = text
        view()?.textColor = color
        view()?.textAlignment = textAlignment
        view()?.numberOfLines = 0
    }
    
    override func doneLoadingChildren() {
        let colors = children?.flatMap { $0 as? WatchStoryboardColor }
        if let color = colors?.first?.color {
            self.color = color
        }
        
        let fonts = children?.flatMap { $0 as? WatchStoryboardFont }
        if let font = fonts?.first?.font {
            self.font = font
        }
        
        children = nil
    }
    
    override func view() -> UILabel? {
        return self.backingView as? UILabel
    }
    
    
    //MARK: - WKInterfaceObjectWithText
    
    override func textForIntrinsicSizeCalulation() -> String? {
        return self.text
    }
    
    override func fontForIntrinsicSizeCalulation() -> UIFont? {
        return self.font
    }
    
    
    //MARK: - WatchKit functions
    
}

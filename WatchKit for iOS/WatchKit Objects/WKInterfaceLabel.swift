//
//  WKInterfaceLabel.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WKInterfaceLabel : WKInterfaceObject<UILabel> {
    
    var text: String? { didSet { backingView?.text = text } }
    var attributedText: NSAttributedString? { didSet { backingView?.attributedText = attributedText } }
    
    var color: UIColor { didSet { backingView?.textColor = color } }
    
    override var intrinsicHeight: CGFloat? {
        return 20.0
    }
    
    required public init(type: String, properties: [String : String]) {
        text = "text" <- properties
        color = UIColor.white
        
        super.init(type: type, properties: properties)
    }
    
    override func doneLoadingChildren() {
        let colors = children?.filter({ $0 is WatchStoryboardColor })
        if let storyboardColor = colors?.first as? WatchStoryboardColor, let color = storyboardColor.color {
            self.color = color
        }
        
        children = nil
    }
    
    
    //MARK: - WatchKit functions
    
}

//
//  WKInterfaceLabel.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WKInterfaceLabel : WKInterfaceObject {
    
    var text: String? { didSet { view()?.text = text } }
    var attributedText: NSAttributedString? { didSet { view()?.attributedText = attributedText } }
    
    var color: UIColor { didSet { view()?.textColor = color } }
    var textAlignment: NSTextAlignment { didSet { view()?.textAlignment = textAlignment } }
    
    
    //MARK: - Set up
    
    required public init(type: String, properties: [String : String]) {
        text = "text" <- properties
        color = UIColor.white
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
        let colors = children?.filter({ $0 is WatchStoryboardColor })
        if let storyboardColor = colors?.first as? WatchStoryboardColor, let color = storyboardColor.color {
            self.color = color
        }
        
        children = nil
    }
    
    override func view() -> UILabel? {
        return self.backingView as? UILabel
    }
    
    
    //MARK: - Dynamic sizing
    
    func idealSize(constrainedSize: CGSize) -> CGSize {
        let attributes: [String : AnyObject] = [NSFontAttributeName : self.view()!.font]
        let drawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let content = NSString(string: self.text ?? "")
        return content.boundingRect(with: constrainedSize,
                                    options: drawingOptions,
                                    attributes: attributes,
                                    context: nil).size
    }
    
    override var intrinsicHeight: Length? {
        if let superviewWidth = self.view()?.superview?.frame.width {
            let constrainedSize = CGSize(width: superviewWidth, height: 1000)
            let idealSize = self.idealSize(constrainedSize: constrainedSize)
            return Length.absolute(idealSize.height)
        }
        return Length.absolute(16.0)
    }
    
    override var intrinsicWidth: Length? {
        if let height = self.intrinsicHeight?.numberValue {
            let constrainedSize = CGSize(width: 1000, height: height)
            let idealSize = self.idealSize(constrainedSize: constrainedSize)
            return Length.absolute(idealSize.width)
        }
        return nil
    }

    
    
    //MARK: - WatchKit functions
    
}

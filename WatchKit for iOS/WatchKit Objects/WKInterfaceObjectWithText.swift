//
//  WKInterfaceObjectWithText.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation
import UIKit

open class WKInterfaceObjectWithText : WKInterfaceObject {
    
    
    //MARK: - Override Points
    
    func textForIntrinsicSizeCalulation() -> String? {
        return nil
    }
    
    func fontForIntrinsicSizeCalulation() -> UIFont? {
        return nil
    }
    
    func paddingForIntrinsicSizeCalculation() -> CGFloat? {
        return nil
    }
    
    private var padding: CGFloat {
        return (paddingForIntrinsicSizeCalculation() ?? 0) * 2
    }
    
    
    //MARK: - Dynamic sizing
    
    private func idealSize(constrainedSize: CGSize) -> CGSize {
        let text = self.textForIntrinsicSizeCalulation() ?? "word"
        let systemFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let font = self.fontForIntrinsicSizeCalulation() ?? systemFont
        
        let content = NSString(string: text)
        return content.boundingRect(with: constrainedSize,
                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                    attributes: [.font : font],
                                    context: nil).size
    }
    
    override var intrinsicHeightValue: Length? {
        if let superviewWidth = self.view()?.superview?.frame.width {
            let constrainedSize = CGSize(width: superviewWidth, height: 1000)
            let idealSize = self.idealSize(constrainedSize: constrainedSize)
            return Length.absolute(idealSize.height + padding)
        }
        
        let systemFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let font = self.fontForIntrinsicSizeCalulation() ?? systemFont
        return Length.absolute(font.pointSize + padding)
    }
    
    override var intrinsicWidthValue: Length? {
        if let height = self.intrinsicHeightValue?.numberValue {
            let constrainedSize = CGSize(width: 1000, height: height)
            let idealSize = self.idealSize(constrainedSize: constrainedSize)
            return Length.absolute(idealSize.width + padding)
        }
        
        return nil
    }
    
    
}

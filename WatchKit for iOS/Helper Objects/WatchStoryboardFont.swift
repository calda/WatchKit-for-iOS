//
//  WatchStoryboardFont.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import Foundation
import UIKit

class WatchStoryboardFont : WatchComponent {
    
    let font: UIFont?
    let key: String
    
    required init(type: String, properties: [String : String]) {
        self.key = ("key" <- properties) ?? "<unknown key>"
        
        if let styleName: String = "style" <- properties {
            let style = WKFontStyle.fromVerboseReferenceString(string: styleName)
            self.font = style.font
        }
        
        else if let size: CGFloat = "pointSize" <- properties {
            let weightString: String = ("weight" <- properties) ?? "regular"
            let weight = WKFontStyle.weightForString(string: weightString)
            self.font = UIFont.systemFont(ofSize: size, weight: weight)
        }
            
        else {
            self.font = nil
        }
        
        super.init(type: type, properties: properties)
    }
    
}

enum WKFontStyle {
    case headline, body, caption1, caption2, footnote
    
    var spec: (weight: UIFont.Weight, size: CGFloat, leading: CGFloat, tracking: CGFloat) {
        switch self {
            case .headline: return (weight: .semibold, size: 16, leading: 18.5, tracking: 0)
            case .body:     return (weight: .regular, size: 16, leading: 18.5, tracking: 0)
            case .caption1: return (weight: .regular, size: 15, leading: 17.5, tracking: 5)
            case .caption2: return (weight: .regular, size: 14, leading: 16.5, tracking: 14)
            case .footnote: return (weight: .regular, size: 13, leading: 15.5, tracking: 16)
        }
    }
    
    var font: UIFont {
        return UIFont.systemFont(ofSize: spec.size, weight: spec.weight)
    }
    
    static func fromVerboseReferenceString(string: String?) -> WKFontStyle {
        if string == "UICTFontTextStyleHeadline" { return .headline }
        if string == "UICTFontTextStyleCaption1" { return .caption1 }
        if string == "UICTFontTextStyleCaption2" { return .caption2 }
        if string == "UICTFontTextStyleFootnote" { return .footnote }
        return .body
    }
    
    static func weightForString(string: String) -> UIFont.Weight {
        if string == "ultralight" { return .ultraLight }
        if string == "thin" { return .thin }
        if string == "light" { return .light }
        if string == "regular" { return .regular }
        if string == "medium" { return .medium }
        if string == "semibold" { return .semibold }
        if string == "bold" { return .bold }
        if string == "heavy" { return .heavy }
        if string == "black" { return .black }
        return .regular
    }
    
}

//
//  WatchStoryboardAction.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class WatchStoryboardAction : WatchComponent {
    
    let selectorName: String?
    
    required public init(type: String, properties: [String : String]) {
        self.selectorName = "selector" <- properties
        super.init(type: type, properties: properties)
    }
    
    func applySelector(from sender: UIButton?, to responder: WKInterfaceController?) {
        guard let selectorName = self.selectorName else { return }
        guard let button = sender else { return }
        guard let controller = responder else { return }
        
        let selector = Selector(selectorName)
        button.addTarget(controller, action: selector, for: .primaryActionTriggered)
    }
    
}

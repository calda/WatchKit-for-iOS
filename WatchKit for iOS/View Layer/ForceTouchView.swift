//
//  ForceTouchView.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

class ForceTouchView : UIImageView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first { checkForForceTouch(on: touch) }
        
        (self as UIResponder).next?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first { checkForForceTouch(on: touch) }
        
        (self as UIResponder).next?.touchesMoved(touches, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(event?.allTouches?.first?.force)
        return false
    }
    
    func checkForForceTouch(on touch: UITouch) {
        print(touch.force)
    }
    
    
    
}

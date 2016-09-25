//
//  ComponentWithBackingView.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

public protocol UIViewBacked {
    
    associatedtype ViewType : UIView
    
    func view() -> ViewType?
    
}

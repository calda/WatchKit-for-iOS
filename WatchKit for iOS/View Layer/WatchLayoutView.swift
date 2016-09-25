//
//  WatchControllerView.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

public class WatchLayoutView : UIView {
    
    weak var delegate: WatchLayoutDelegate?
    
    override public func layoutSubviews() {
        guard let delegate = delegate else { return }
        
        let childComponents = delegate.watchLayoutChildrenComponents?() ?? []
        let subviews = childComponents.flatMap { $0 as? WKInterfaceObject }
        
        let direction = delegate.watchLayoutDirection()
        let initialSpacing = delegate.watchLayoutPaddingAtStart?() ?? 0
        let regularSpacing = delegate.watchLayoutSpacing?() ?? 4.0
        
        for (index, subview) in subviews.enumerated() {
            let previousSubview: WKInterfaceObject? = (index == 0 ? nil : subviews[index - 1])
            let spacing = (previousSubview == nil ? initialSpacing : regularSpacing)
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            if direction == .vertical {
                y = (previousSubview?.view()?.frame.maxY ?? 0.0) + spacing
            } else {
                x = (previousSubview?.view()?.frame.maxX ?? 0.0) + spacing
            }
            
            var availableWidth = self.frame.width
            if direction == .horizontal {
                let spaceFromPadding = initialSpacing + (regularSpacing * CGFloat(subviews.count - 1))
                availableWidth = self.frame.width - spaceFromPadding
            }
            
            let height = (subview.height ?? subview.intrinsicHeight)?.length(in: self.frame.height)
            let width = (subview.width ?? subview.intrinsicWidth)?.length(in: availableWidth)
            
            subview.view()?.frame = CGRect(x: x, y: y, width: width ?? 0, height: height ?? 0)
        }
    }
    
}

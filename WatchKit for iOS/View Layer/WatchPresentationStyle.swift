//
//  WatchPresentationStyle.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

enum WatchPresentationDirection {
    case forward, backward
}

enum WatchPresentationStyle {
    case modal, push
    
    static func fromString(_ string: String) -> WatchPresentationStyle {
        if string.lowercased() == "push" { return .push }
        return .modal
    }
    
    func transition(_ direction: WatchPresentationDirection, to controller: WKInterfaceController, in storyboard: WatchStoryboard, completion: (() -> ())?) {
        
        let options = (direction, self)
        
        let animate: (WKInterfaceController, WatchStoryboard, (() -> ())?) -> ()
        if options == (.forward, .modal) { animate = forwardModal }
        else if options == (.backward, .modal) { animate = backwardsModal }
        else if options == (.forward, .push) { animate = forwardPush }
        else { animate = backwardsPush }
        
        animate(controller, storyboard, completion)
    }
    
    
    //MARK: - Modal Presentation
    
    private func forwardModal(to controller: WKInterfaceController, in storyboard: WatchStoryboard, completion: (() -> ())?) {
        guard let currentView = storyboard.contentView.subviews.first else { return }
        guard let newView = controller.view else { return }
        
        storyboard.contentView.addSubview(newView)
        newView.frame.origin = CGPoint(x: 0, y: storyboard.contentView.frame.height)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            newView.frame.origin = .zero
        }, completion: { _ in
            currentView.removeFromSuperview()
            completion?()
        })
    }
    
    private func backwardsModal(to controller: WKInterfaceController, in storyboard: WatchStoryboard, completion: (() -> ())?) {
        guard let currentView = storyboard.contentView.subviews.first else { return }
        guard let newView = controller.view else { return }
        
        storyboard.contentView.addSubview(newView)
        storyboard.contentView.sendSubview(toBack: newView)
        newView.frame.origin = .zero
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
                currentView.frame.origin = CGPoint(x: 0, y: storyboard.contentView.frame.height)
            }, completion: { _ in
                currentView.removeFromSuperview()
                completion?()
        })
    }
    
    
    //MARK: - Push Presentation
    
    private func forwardPush(to controller: WKInterfaceController, in storyboard: WatchStoryboard, completion: (() -> ())?) {
        guard let currentView = storyboard.contentView.subviews.first else { return }
        guard let newView = controller.view else { return }
        
        storyboard.contentView.addSubview(newView)
        newView.frame.origin = CGPoint(x: storyboard.contentView.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            newView.frame.origin = .zero
            currentView.frame.origin = CGPoint(x: -40, y: 0)
            currentView.alpha = 0.0
        }, completion: { _ in
            currentView.removeFromSuperview()
            completion?()
        })
    }
    
    private func backwardsPush(to controller: WKInterfaceController, in storyboard: WatchStoryboard, completion: (() -> ())?) {
        guard let currentView = storyboard.contentView.subviews.first else { return }
        guard let newView = controller.view else { return }
        
        storyboard.contentView.addSubview(newView)
        storyboard.contentView.sendSubview(toBack: newView)
        newView.frame.origin = CGPoint(x: -40, y: 0)
        newView.alpha = 0.0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            currentView.frame.origin = CGPoint(x: storyboard.contentView.frame.width, y: 0)
            newView.frame.origin = .zero
            newView.alpha = 1.0
        }, completion: { _ in
            currentView.removeFromSuperview()
            completion?()
        })
    }

}

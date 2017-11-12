//
//  WKInterfaceController.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit

open class WKInterfaceController : WatchComponent, WatchLayoutDelegate {
    
    let identifier: String?
    let title: String?
    let customClassName: String?
    
    public var view: UIView!
    var scrollView: UIScrollView!
    var contentView: WatchLayoutView!
    
    weak var storyboard: WatchStoryboard?
    weak var presenter: WKInterfaceController?
    var presentationStyle: WatchPresentationStyle?
    
    let spacing: CGFloat
    
    public var menuItems: [WatchStoryboardMenuItem] {
        return self.children?.flatMap { $0 as? WatchStoryboardMenuItem } ?? []
    }
    
    required public init(type: String, properties: [String : String]) {
        self.identifier = "identifier" <- properties
        self.title = "title" <- properties
        self.customClassName = "customClass" <- properties
        self.spacing = ("spacing" <- properties) ?? 4.0
        
        super.init(type: type, properties: properties)
        setUpView()
    }
    
    override func addChild(_ child: WatchComponent) {
        if let interfaceObject = child as? WKInterfaceObject {
            interfaceObject.controller = self
            
            if let backingView = interfaceObject.backingView {
                self.contentView.addSubview(backingView)
            }
        }
        
        super.addChild(child)
    }
    
    override func doneLoadingChildren() {
        let outlets = self.children?.flatMap{ $0 as? WatchStoryboardOutlet } ?? []
        outlets.forEach { outlet in
            outlet.connectToView(in: self)
        }
        
        print("done loading \(self.title ?? "unnamed Controller")")
    }
    
    func setUpView() {
        let viewBounds = CGRect(x: 0, y: 0, width: 156, height: 195)
        self.view = UIView(frame: viewBounds)
        self.view.backgroundColor = UIColor.black
        
        //set up status bar
        let statusBarBounds = CGRect(x: 0, y: 0, width: 156, height: 21)
        let statusBar = UIView(frame: statusBarBounds)
        self.view.addSubview(statusBar)
        
        let timeLabelBounds = CGRect(x: 113, y: 3, width: 40, height: 16)
        let timeLabel = UILabel(frame: timeLabelBounds)
        timeLabel.text = "10:09"
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        timeLabel.textAlignment = .right
        timeLabel.textColor = UIColor.white
        statusBar.addSubview(timeLabel)
        
        let titleButtonRect = CGRect(x: 3, y: 3, width: 102, height: 16)
        let titleButton = UIButton(frame: titleButtonRect)
        titleButton.setTitle(self.title ?? "Back", for: .normal)
        titleButton.setTitleColor(UIColor(white: 0.5, alpha: 1.0), for: .normal)
        titleButton.titleLabel?.font = timeLabel.font
        titleButton.contentHorizontalAlignment = .left
        titleButton.addTarget(self, action: #selector(self.titleButtonPressed), for: .primaryActionTriggered)
        statusBar.addSubview(titleButton)
        
        
        //set up content scroll view
        let scrollViewBounds = CGRect(x: 0, y: 21, width: 156, height: 174)
        self.scrollView = UIScrollView(frame: scrollViewBounds)
        self.view.addSubview(self.scrollView)
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let contentViewBounds = CGRect(x: 0, y: 0, width: 156, height: 160)
        self.contentView = WatchLayoutView(frame: contentViewBounds)
        self.contentView.delegate = self
        self.contentView.clipsToBounds = false
        scrollView.addSubview(self.contentView)
    }
    
    //MARK: - Watch Layout Delegate
    
    func watchLayoutSpacing() -> CGFloat {
        return self.spacing
    }
    
    func watchLayoutChildrenComponents() -> [AnyObject] {
        return self.children ?? []
    }
    
    func watchLayoutDirection() -> WKInterfaceLayoutDirection {
        return .vertical
    }
    
    func watchLayoutSetsOwnFrameHeight() -> Bool {
        return true
    }
    
    
    //MARK: - User Interaction
    
    @objc func titleButtonPressed() {
        if self.presentationStyle == .push {
            self.pop()
        } else {
            self.dismiss()
        }
    }
    
    
    //MARK: - WatchKit Presentation Methods
    
    public func presentController(withName name: String, context: Any?) {
        self.segue(withName: name, orId: nil, style: .modal, direction: .forward, context: context)
    }
    
    public func presentController(withId id: String, context: Any?) {
        self.segue(withName: nil, orId: id, style: .modal, direction: .forward, context: context)
    }
    
    public func dismiss() {
        self.segue(withName: nil, orId: nil, style: .modal, direction: .backward, context: nil)
    }
    
    public func pushController(withName name: String, context: Any?) {
        self.segue(withName: name, orId: nil, style: .push, direction: .forward, context: context)
    }
    
    public func pushController(withId id: String, context: Any?) {
        self.segue(withName: nil, orId: id, style: .push, direction: .forward, context: context)
    }
    
    public func pop() {
        self.segue(withName: nil, orId: nil, style: .push, direction: .backward, context: nil)
    }
    
    private func segue(withName name: String?, orId id: String?, style: WatchPresentationStyle, direction: WatchPresentationDirection, context: Any?) {
        guard let storyboard = self.storyboard else { return }
        
        //choose correct controller
        let controller: WKInterfaceController!
        
        if let id = id {
            controller = storyboard.controller(forId: id)
        } else if let name = name {
            controller = storyboard.controller(forName: name)
        } else if direction == .backward {
            controller = self.presenter
        } else {
            controller = nil
        }
        
        if controller == nil {
            return
        }
        
        if direction == .forward {
            controller.presenter = self
            controller.presentationStyle = style
        }
        
        //call lifecycle methods and animate
        if direction == .forward {
            controller.awake(withContext: context)
        }
        
        self.willDisappear()
        controller.willActivate()

        storyboard.delegate?.storyboard(storyboard, didUpdateForceTouchOptionsTo: controller.menuItems)
        
        style.transition(direction, to: controller, in: storyboard, completion: {
            self.didDeactivate()
            controller.didAppear()
            storyboard.currentController = controller
        })
    }
    
    
    //MARK: - WatchKit lifecycle methods
    
    open func awake(withContext context: Any?) { }
    open func willActivate() { }
    open func didDeactivate() { }
    open func didAppear() { }
    open func willDisappear() { }
    
    
}

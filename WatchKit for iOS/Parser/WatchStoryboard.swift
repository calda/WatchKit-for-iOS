//
//  WatchStoryboard.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

import UIKit
import Foundation

public class WatchStoryboard : NSObject, XMLParserDelegate {

    public var applicationNamespace: String
    var initialControllerId: String?
    
    public var initialController: WKInterfaceController?
    public var currentController: WKInterfaceController?
    
    public var watchView: UIView
    var contentView: UIView
    var forceTouchView: ForceTouchView
    
    //MARK: - Set up
    
    public init?(fileName: String, applicationNamespace: String) {
        self.applicationNamespace = applicationNamespace
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "xml") else { return nil }
        guard let xmlData = NSData(contentsOfFile: path) else { return nil }
        
        self.initialControllerId = nil
        self.watchView = UIView()
        self.contentView = UIView()
        self.forceTouchView = ForceTouchView()
        
        super.init()
        
        let xmlParser = XMLParser(data: xmlData as Data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    func setUpViewForInitialController() {
        let viewSize = CGSize(width: 156, height: 195)
        self.watchView.frame.size = viewSize
        self.watchView.clipsToBounds = true
        self.watchView.layer.masksToBounds = true
        
        self.contentView.frame = CGRect(origin: .zero, size: viewSize)
        self.watchView.addSubview(self.contentView)
        
        self.forceTouchView.frame = CGRect(origin: .zero, size: viewSize)
        self.forceTouchView.isUserInteractionEnabled = true
        self.watchView.addSubview(self.forceTouchView)
        
        if let initialController = self.initialController {
            initialController.willActivate()
            self.contentView.addSubview(initialController.view)
            initialController.didAppear()
            
            self.currentController = self.initialController
        }
    }
    
    func controller(forName name: String) -> WKInterfaceController? {
        return self.rootComponents.flatMap { $0 as? WKInterfaceController }.first { $0.identifier == name }
    }
    
    func controller(forId id: String) -> WKInterfaceController? {
        return self.rootComponents.flatMap { $0 as? WKInterfaceController }.first { $0.id == id }
    }
    
    //MARK: - Parse
    
    var rootComponents = [WatchComponent]()
    var componentsInProgress: Stack<WatchComponent> = Stack()
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "document" {
            self.initialControllerId = "initialViewController" <- attributeDict
        }
        
        if let component = WatchComponent.create(type: elementName, properties: attributeDict, namespace: self.applicationNamespace) {
            componentsInProgress.top?.addChild(component)
            componentsInProgress.push(component)
            
            if let controller = component as? WKInterfaceController {
                controller.storyboard = self
                
                if controller.id == self.initialControllerId {
                    self.initialController = controller
                }
            }
        }
        
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard let currentComponent = componentsInProgress.top else { return }
        if currentComponent.type != elementName { return }
        
        guard let finishedComponent = componentsInProgress.pop() else { return }
        finishedComponent.doneLoadingChildren()
        
        //if there are no more components in progress, this component is a root object
        if componentsInProgress.top == nil {
            rootComponents.append(finishedComponent)
        }
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        setUpViewForInitialController()
    }
    
    
}

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

    var applicationNamespace: String
    
    //MARK: - Set up
    
    public init?(fileName: String, applicationNamespace: String) {
        self.applicationNamespace = applicationNamespace
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "xml") else { return nil }
        guard let xmlData = NSData(contentsOfFile: path) else { return nil }
        
        super.init()
        
        let xmlParser = XMLParser(data: xmlData as Data)
        xmlParser.delegate = self
        xmlParser.parse()
        
        print(rootComponents)
    }
    
    
    //MARK: - Parse
    
    public var rootComponents = [WatchComponent]()
    var componentsInProgress: Stack<WatchComponent> = Stack()
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if let component = WatchComponent.create(type: elementName, properties: attributeDict, namespace: self.applicationNamespace) {
            componentsInProgress.top?.addChild(component)
            componentsInProgress.push(push: component)
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
    
    
}

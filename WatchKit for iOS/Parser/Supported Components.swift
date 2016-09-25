//
//  WKiOS_SUPPORTED_COMPONENTS.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/24/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

let WKiOS_SUPPORTED_COMPONENTS: [String : WatchComponent.Type] = [
    
    //WatchKit objects
    "controller" : WKInterfaceController.self,
    "group" : WKInterfaceGroup.self,
    "label" : WKInterfaceLabel.self,
    "button" : WKInterfaceButton.self,
    
    //Helper Objects
    "color" : WatchStoryboardColor.self,
    "fontDescription" : WatchStoryboardFont.self,
    "action" : WatchStoryboardAction.self,
    "segue" : WatchStoryboardSegue.self
    
]

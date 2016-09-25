//
//  WatchStoryboardSeugue.swift
//  Basic Watch App
//
//  Created by Cal Stephens on 9/25/16.
//  Copyright © 2016 Cal Stephens. All rights reserved.
//

class WatchStoryboardSegue : WatchComponent {
    
    let destinationId: String?
    let presentationStyle: WatchPresentationStyle?
    
    required public init(type: String, properties: [String : String]) {
        self.destinationId = "destination" <- properties
        
        if let segueKind: String = "kind" <- properties {
            self.presentationStyle = WatchPresentationStyle.fromString(segueKind)
        } else {
            self.presentationStyle = nil
        }
        
        super.init(type: type, properties: properties)
    }
    
}

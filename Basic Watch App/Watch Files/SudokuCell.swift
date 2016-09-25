//
//  SudokuCell.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit_iOS
import UIKit

class SudokuCell {
    
    var solutionEmoji: Emoji?
    var revealed: Bool = false
    
    var emoji: Emoji?
    var baseColor: UIColor
    var quadrant: Int
    
    var currentColor : UIColor?
    
    init(_ quadrant: Int) {
        self.quadrant = quadrant
        if quadrant == 2 || quadrant == 3 {
            baseColor = UIColor(white: 0.1, alpha: 1.0)
        } else {
            baseColor = UIColor(white: 0.15, alpha: 1.0)
        }
    }
    
    func renderOnButton(_ button: WKInterfaceButton){
        button.setTitle(revealed ? solutionEmoji?.getString() : emoji?.getString())
        if let currentColor = currentColor {
            button.setBackgroundColor(currentColor)
        } else {
            button.setBackgroundColor(baseColor)
        }
    }
    
    func setSelectedOnButton(_ button: WKInterfaceButton) {
        var baseWhite : CGFloat = 0.0
        baseColor.getWhite(&baseWhite, alpha: nil)
        button.setBackgroundColor(UIColor(hue: 0.5, saturation: baseWhite * 1.5, brightness: baseWhite * 1.5, alpha: 1.0))
    }
    
    func setVictoryOnButton(_ button: WKInterfaceButton) {
        var baseWhite : CGFloat = 0.0
        baseColor.getWhite(&baseWhite, alpha: nil)
        button.setBackgroundColor(UIColor(hue: 0.33, saturation: baseWhite * 2.5, brightness: baseWhite * 2.5, alpha: 1.0))
    }
    
    func pingNoOnButton(_ button: WKInterfaceButton) {
        var baseWhite : CGFloat = 0.0
        baseColor.getWhite(&baseWhite, alpha: nil)
        button.setBackgroundColor(UIColor(hue: 0.0, saturation: baseWhite * 3, brightness: baseWhite * 3, alpha: 1.0))
        
        //wait a sec and then return to normal
        let time = DispatchTime.now() + Double(Int64(0.75 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            button.setBackgroundColor(self.baseColor)
        })
    }
    
}

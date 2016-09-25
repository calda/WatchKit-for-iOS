//
//  VictoryScreen.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit_iOS

class VictoryScreen : WKInterfaceController {
    
    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    @IBOutlet weak var emojisLabel: WKInterfaceLabel!
    
    var main : InterfaceController?
    
    override func awake(withContext context: Any?) {
        main = (context as! InterfaceController)
        
        let startTime = main!.startTime!
        let elapsed = Date().timeIntervalSince(startTime as Date)
        let durationSeconds = Int(elapsed)
        
        let printMinutes : Int = durationSeconds / 60
        let printSeconds : Int = durationSeconds % 60
        timeLabel.setText("You Won in\n\(printMinutes) min \(printSeconds) sec")
    }
    
    override func willActivate() {
        let emojiText = Emoji.one.getString() + Emoji.two.getString() + Emoji.three.getString() + Emoji.four.getString()
        emojisLabel.setText(emojiText)
    }
    
    @IBAction func playAgain() {
        main!.restart()
        self.dismiss()
    }
    
    @IBAction func customize() {
        self.presentController(withName: "customize", context: self)
    }
}

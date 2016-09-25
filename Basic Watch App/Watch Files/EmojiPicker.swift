//
//  EmojiPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit_iOS

class EmojiPicker : WKInterfaceController {
    
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    
    var main : InterfaceController?
    
    override func awake(withContext context: Any?) {
        main = (context as! InterfaceController)
    }
    
    override func willActivate() {
        super.willActivate()
        
        button1.setTitle(EMOJI_1)
        button2.setTitle(EMOJI_2)
        button3.setTitle(EMOJI_3)
        button4.setTitle(EMOJI_4)
    }
    
    func pressed(_ emoji: Emoji?) {
        main!.cell[main!.selectedCell.0][main!.selectedCell.1].emoji = emoji
        self.pop()
    }
    
    @IBAction func pressed1() {
        pressed(Emoji.one)
    }
    
    @IBAction func pressed2() {
        pressed(Emoji.two)
    }
    
    @IBAction func pressed3() {
        pressed(Emoji.three)
    }
    
    @IBAction func pressed4() {
        pressed(Emoji.four)
    }
    
    @IBAction func pressedClear() {
        pressed(nil)
    }
}

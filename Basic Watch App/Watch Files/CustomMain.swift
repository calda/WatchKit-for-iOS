//
//  EmojiPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit_iOS

class CustomMain : WKInterfaceController {
    
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    
    var selectedEmoji : Emoji?
    
    override func willActivate() {
        super.willActivate()
        
        button1.setTitle(EMOJI_1)
        button2.setTitle(EMOJI_2)
        button3.setTitle(EMOJI_3)
        button4.setTitle(EMOJI_4)
    }
    
    func pressed(_ emoji: Emoji) {
        selectedEmoji = emoji
        self.presentController(withName: "customPicker", context: self)
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
    
    @IBAction func randomize() {
        var emojis = ["🌎","🙌","🎸","😅","🍕","🔮","😇","👔","🐢","💨","🔥","💩","😊","😪","😟","👾","😍","🚙","😈","😳","😞","😓","😙","😹","👩","🐄","🐥","🐽","🐯","🐮","💐","🌲","🍂","🐎","🐦","🙈","🙉","🐩","🎐","💙","💕","👑","🎁","🍵","🍬","🍮","🍥","🍭","🍤","🚅","🎠","🎹","🎳","🎱","🎩","🎺","🎵","🚀","🚓","🚨","🚏","🚅","🏡","💉","🇩🇪","🇬🇧","〽️","📱","👔","👠","💸","‼️"]
        
        var selected : [String] = []
        
        while selected.count < 4 {
            let selectedStart = selected.count
            while selectedStart == selected.count {
                
                let random = Int(arc4random_uniform(UInt32(emojis.count - 1)))
                let emoji = emojis[random]
                
                //check selected does not contain emoji
                var isUnique = true
                for other in selected {
                    if other == emoji {
                        isUnique = false
                    }
                }
                
                if isUnique {
                    selected.append(emoji)
                }
                
            }
        }
        
        EMOJI_1 = selected[0]
        EMOJI_2 = selected[1]
        EMOJI_3 = selected[2]
        EMOJI_4 = selected[3]
        
        let store = NSUbiquitousKeyValueStore.default()
        store.synchronize()
        
        store.set(selected[0], forKey: "EMOJI_1")
        store.set(selected[1], forKey: "EMOJI_2")
        store.set(selected[2], forKey: "EMOJI_3")
        store.set(selected[3], forKey: "EMOJI_4")
        
        button1.setTitle(EMOJI_1)
        button2.setTitle(EMOJI_2)
        button3.setTitle(EMOJI_3)
        button4.setTitle(EMOJI_4)
    }
}

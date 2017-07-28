//
//  CustomPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit_iOS

class CustomPicker: WKInterfaceController {
    
    var main : CustomMain?
    let emojiMap = [
        ["😎", "❤️", "🔥", "🎉"],
        ["✌️", "💩", "😈", "😇"],
        ["💯", "🇺🇸", "😍", "❄️"],
        ["😂", "😏", "🍕", "👯"],
        ["💀", "👾", "🐔", "🌚"],
        ["🍆", "🌎", "🍑", "💔"],
        ["🚙", "🔮", "🙌", "😘"],
        ["🚨", "🇬🇧", "🏊", "👑"],
        ["🎃", "🎊", "🎯", "💸"],
        ["💉", "💮", "👌", "💪"],
        ["👺", "🙏", "👅", "🍭"]
    ]
    
    override func awake(withContext context: Any?) {
        main = (context as! CustomMain)
        super.awake(withContext: context)
    }
    
    func processTap(_ col: Int, _ row: Int) {
        let selectedEmoji = emojiMap[col][row]
        
        let otherEmojis = [EMOJI_1, EMOJI_2, EMOJI_3, EMOJI_4]
        var isNewToSet = true
        for other in otherEmojis {
            if other == selectedEmoji {
                isNewToSet = false
            }
        }
        
        if isNewToSet {
            
            let store = NSUbiquitousKeyValueStore.default()
            store.synchronize()
            
            if main!.selectedEmoji! == .one {
                EMOJI_1 = selectedEmoji
                store.set(selectedEmoji, forKey: "EMOJI_1")
            } else if main!.selectedEmoji! == .two {
                EMOJI_2 = selectedEmoji
                store.set(selectedEmoji, forKey: "EMOJI_2")
            } else if main!.selectedEmoji! == .three {
                EMOJI_3 = selectedEmoji
                store.set(selectedEmoji, forKey: "EMOJI_3")
            } else if main!.selectedEmoji! == .four {
                EMOJI_4 = selectedEmoji
                store.set(selectedEmoji, forKey: "EMOJI_4")
            }
        }
        
        self.dismiss()
        
    }
    
    @IBAction func pressed00() {
        processTap(0, 0)
    }
    
    @IBAction func pressed01() {
        processTap(0, 1)
    }
    
    @IBAction func pressed02() {
        processTap(0, 2)
    }
    
    @IBAction func pressed03() {
        processTap(0, 3)
    }
    
    @IBAction func pressed10() {
        processTap(1, 0)
    }
    
    @IBAction func pressed11() {
        processTap(1, 1)
    }
    
    @IBAction func pressed12() {
        processTap(1, 2)
    }
    
    @IBAction func pressed13() {
        processTap(1, 3)
    }
    
    @IBAction func pressed20() {
        processTap(2, 0)
    }
    
    @IBAction func pressed21() {
        processTap(2, 1)
    }
    
    @IBAction func pressed22() {
        processTap(2, 2)
    }
    
    @IBAction func pressed23() {
        processTap(2, 3)
    }
    
    @IBAction func pressed30() {
        processTap(3, 0)
    }
    
    @IBAction func pressed31() {
        processTap(3, 1)
    }
    
    @IBAction func pressed32() {
        processTap(3, 2)
    }
    
    @IBAction func pressed33() {
        processTap(3, 3)
    }
    
    @IBAction func pressed40() {
        processTap(4, 0)
    }
    
    @IBAction func pressed41() {
        processTap(4, 1)
    }
    
    @IBAction func pressed42() {
        processTap(4, 2)
    }
    
    @IBAction func pressed43() {
        processTap(4, 3)
    }
    
    @IBAction func pressed50() {
        processTap(5, 0)
    }
    
    @IBAction func pressed51() {
        processTap(5, 1)
    }
    
    @IBAction func pressed52() {
        processTap(5, 2)
    }
    
    @IBAction func pressed53() {
        processTap(5, 3)
    }
    
    @IBAction func pressed60() {
        processTap(6, 0)
    }
    
    @IBAction func pressed61() {
        processTap(6, 1)
    }
    
    @IBAction func pressed62() {
        processTap(6, 2)
    }
    
    @IBAction func pressed63() {
        processTap(6, 3)
    }
    
    @IBAction func pressed70() {
        processTap(7, 0)
    }
    
    @IBAction func pressed71() {
        processTap(7, 1)
    }
    
    @IBAction func pressed72() {
        processTap(7, 2)
    }
    
    @IBAction func pressed73() {
        processTap(7, 3)
    }
    
    @IBAction func pressed80() {
        processTap(8, 0)
    }
    
    @IBAction func pressed81() {
        processTap(8, 1)
    }
    
    @IBAction func pressed82() {
        processTap(8, 2)
    }
    
    @IBAction func pressed83() {
        processTap(8, 3)
    }
    
    @IBAction func pressed90() {
        processTap(9, 0)
    }
    
    @IBAction func pressed91() {
        processTap(9, 1)
    }
    
    @IBAction func pressed92() {
        processTap(9, 2)
    }
    
    @IBAction func pressed93() {
        processTap(9, 3)
    }
    
    @IBAction func presseda0() {
        processTap(10, 0)
    }
    
    @IBAction func presseda1() {
        processTap(10, 1)
    }
    
    @IBAction func presseda2() {
        processTap(10, 2)
    }
    
    @IBAction func presseda3() {
        processTap(10, 3)
    }
    
}

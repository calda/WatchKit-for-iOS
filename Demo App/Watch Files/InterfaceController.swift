//
//  InterfaceController.swift
//  Emoji Sudoku WatchKit Extension
//
//  Created by Cal on 5/2/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import WatchKit_iOS
import Foundation

var EMOJI_1 = "😎"
var EMOJI_2 = "❤️"
var EMOJI_3 = "🔥"
var EMOJI_4 = "🎉"

enum Emoji {
    case one, two, three, four
    
    func getString() -> String {
        switch(self) {
            case .one: return EMOJI_1
            case .two: return EMOJI_2
            case .three: return EMOJI_3
            case .four: return EMOJI_4
        }
    }
    
    func getID() -> Int {
        switch(self) {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        }
    }
    
    static func getEmojiConstant(_ string: String) -> Emoji {
        switch(string) {
            case EMOJI_1: return .one
            case EMOJI_2: return .two
            case EMOJI_3: return .three
            default: return .four
        }
    }
    
    func inArrayOnce(_ array: [Emoji?]) -> Bool {
        var count = 0
        for emoji in array {
            if let emoji = emoji {
                if emoji == self {
                    count += 1
                }
            }
        }
        return count == 1
    }
}

class InterfaceController: WKInterfaceController {
    
    // MARK: buttons
    @IBOutlet weak var b00: WKInterfaceButton!
    @IBOutlet weak var b01: WKInterfaceButton!
    @IBOutlet weak var b02: WKInterfaceButton!
    @IBOutlet weak var b03: WKInterfaceButton!
    @IBOutlet weak var b10: WKInterfaceButton!
    @IBOutlet weak var b11: WKInterfaceButton!
    @IBOutlet weak var b12: WKInterfaceButton!
    @IBOutlet weak var b13: WKInterfaceButton!
    @IBOutlet weak var b20: WKInterfaceButton!
    @IBOutlet weak var b21: WKInterfaceButton!
    @IBOutlet weak var b22: WKInterfaceButton!
    @IBOutlet weak var b23: WKInterfaceButton!
    @IBOutlet weak var b30: WKInterfaceButton!
    @IBOutlet weak var b31: WKInterfaceButton!
    @IBOutlet weak var b32: WKInterfaceButton!
    @IBOutlet weak var b33: WKInterfaceButton!
    
    var buttonMap : [[WKInterfaceButton?]] = [[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]]
    var cell : [[SudokuCell]] = [
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)]]
    
    var selectedCell = (0, 0)
    var startTime : Date?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    func processTap(_ col: Int, _ row: Int) {
        print("(\(col), \(row))")
        selectedCell = (col, row)
        if cell[col][row].revealed {
            cell[col][row].pingNoOnButton(buttonMap[col][row]!)
            return
        }
        cell[col][row].setSelectedOnButton(buttonMap[col][row]!)
        self.presentController(withName: "picker", context: self)
    }
    
    override func willActivate() {
        if buttonMap[0][0] == nil {
            //sometimes you just really have to embrace WatchKit
            buttonMap[0][0] = b00
            buttonMap[0][1] = b01
            buttonMap[0][2] = b02
            buttonMap[0][3] = b03
            buttonMap[1][0] = b10
            buttonMap[1][1] = b11
            buttonMap[1][2] = b12
            buttonMap[1][3] = b13
            buttonMap[2][0] = b20
            buttonMap[2][1] = b21
            buttonMap[2][2] = b22
            buttonMap[2][3] = b23
            buttonMap[3][0] = b30
            buttonMap[3][1] = b31
            buttonMap[3][2] = b32
            buttonMap[3][3] = b33
            populateWithSolution()
            
            //pull custom emoji data from iCloud
            let store = NSUbiquitousKeyValueStore.default()
            store.synchronize()
            if store.string(forKey: "EMOJI_1") == nil {
                store.set("😎", forKey: "EMOJI_1")
                store.set("❤️", forKey: "EMOJI_2")
                store.set("🔥", forKey: "EMOJI_3")
                store.set("🎉", forKey: "EMOJI_4")
            }
            else {
                EMOJI_1 = store.string(forKey: "EMOJI_1")!
                EMOJI_2 = store.string(forKey: "EMOJI_2")!
                EMOJI_3 = store.string(forKey: "EMOJI_3")!
                EMOJI_4 = store.string(forKey: "EMOJI_4")!
            }
        }
        
        var userModifiedCount = 0
        
        for row in 0...3 {
            for col in 0...3 {
                cell[row][col].renderOnButton(buttonMap[row][col]!)
                if cell[row][col].emoji != nil && !cell[row][col].revealed {
                    userModifiedCount += 1
                }
            }
        }
        
        if userModifiedCount == 0 {
            startTime = Date()
        }
        
        if validateGrid() {
            //set all green
            for row in 0...3 {
                for col in 0...3 {
                    cell[row][col].setVictoryOnButton(buttonMap[row][col]!)
                }
            }
            
            //wait a sec and then show victory screen
            let time = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.pushController(withName: "victory", context: self)
            })
        }

        super.willActivate()
    }
    
    
    func populateWithSolution() {
        
        func randomEmojiExcluding(_ exclude: [SudokuCell]) -> Emoji {
            var allEmoji : [Emoji] = [.one, .two, .three, .four]
            for cell in exclude {
                for i in 0..<allEmoji.count {
                    if allEmoji[i] == cell.solutionEmoji! {
                        allEmoji.remove(at: i)
                        break
                    }
                }
            }
            if allEmoji.count == 1 {
                return allEmoji[0]
            }
            
            let random = Int(arc4random_uniform(UInt32(allEmoji.count - 1)))
            return allEmoji[random]
        }
        
        func doFor(_ cell: SudokuCell, exclude: [SudokuCell]) {
            let random = randomEmojiExcluding(exclude)
            cell.solutionEmoji = random
        }
        
        //populate
        
        doFor(cell[0][0], exclude: [])
        doFor(cell[0][1], exclude: [cell[0][0]])
        doFor(cell[1][0], exclude: [cell[0][0], cell[0][1]])
        doFor(cell[1][1], exclude: [cell[0][0], cell[0][1], cell[1][0]])
        
        doFor(cell[0][2], exclude: [cell[0][0], cell[0][1]])
        doFor(cell[0][3], exclude: [cell[0][0], cell[0][1], cell[0][2]])
        doFor(cell[1][2], exclude: [cell[1][0], cell[1][1]])
        doFor(cell[1][3], exclude: [cell[1][0], cell[1][1], cell[1][2]])
        
        doFor(cell[2][0], exclude: [cell[0][0], cell[1][0]])
        doFor(cell[3][0], exclude: [cell[0][0], cell[1][0], cell[2][0]])
        doFor(cell[2][1], exclude: [cell[0][1], cell[1][1]])
        doFor(cell[3][1], exclude: [cell[0][1], cell[1][1], cell[2][1]])
        
        doFor(cell[2][2], exclude: [cell[2][0], cell[2][1], cell[0][2], cell[1][2]])
        doFor(cell[3][3], exclude: [cell[3][0], cell[3][1], cell[0][3], cell[1][3]])
        doFor(cell[2][3], exclude: [cell[2][0], cell[2][1], cell[2][2]])
        doFor(cell[3][2], exclude: [cell[3][0], cell[3][1], cell[3][3]])
        
        //reveal six random cells
        
        var allCells : [SudokuCell] = []
        for row in 0...3 {
            for col in 0...3 {
                allCells.append(cell[col][row])
            }
        }
        
        for _ in 0...5 {
            let reveal = Int(arc4random_uniform(UInt32(allCells.count - 1)))
            allCells[reveal].revealed = true
            allCells[reveal].emoji = allCells[reveal].solutionEmoji
            allCells.remove(at: reveal)
        }
        
        if !validateSolution() {
            restart()
        }
        
    }
    
    
    func validateGrid() -> Bool {
        //validate columns
        for col in 0...3 {
            
            var colGroup : [Emoji?] = []
            for row in 0...3 {
                colGroup.append(cell[col][row].emoji)
            }
            if !groupIsValid(colGroup) {
                return false
            }
            
        }
        
        //validate rows
        for row in 0...3 {
            
            var rowGroup : [Emoji?] = []
            for col in 0...3 {
                rowGroup.append(cell[col][row].emoji)
            }
            if !groupIsValid(rowGroup) {
                return false
            }
            
        }
        
        //validate quads
        let cornerCells : [(Int, Int)] = [(0, 0), (0, 2), (2, 0), (2, 2)]
        for cornerCell in cornerCells {
            
            var quadCells : [Emoji?] = []
            for x in 0...1 {
                for y in 0...1 {
                    let col = cornerCell.0 + x
                    let row = cornerCell.1 + y
                    quadCells.append(cell[col][row].emoji)
                }
            }
            if !groupIsValid(quadCells) {
                return false
            }
        }
        
        return true
    }
    
    //duplicated because I'm lazy OOPS
    func validateSolution() -> Bool {
        //validate columns
        for col in 0...3 {
            
            var colGroup : [Emoji?] = []
            for row in 0...3 {
                colGroup.append(cell[col][row].solutionEmoji)
            }
            if !groupIsValid(colGroup) {
                return false
            }
            
        }
        
        //validate rows
        for row in 0...3 {
            
            var rowGroup : [Emoji?] = []
            for col in 0...3 {
                rowGroup.append(cell[col][row].solutionEmoji)
            }
            if !groupIsValid(rowGroup) {
                return false
            }
            
        }
        
        //validate quads
        let cornerCells : [(Int, Int)] = [(0, 0), (0, 2), (2, 0), (2, 2)]
        for cornerCell in cornerCells {
            
            var quadCells : [Emoji?] = []
            for x in 0...1 {
                for y in 0...1 {
                    let col = cornerCell.0 + x
                    let row = cornerCell.1 + y
                    quadCells.append(cell[col][row].solutionEmoji)
                }
            }
            if !groupIsValid(quadCells) {
                return false
            }
        }
        
        return true
    }
    
    
    func groupIsValid(_ group: [Emoji?]) -> Bool {
        if group.count != 4 { return false }
        let one = Emoji.one.inArrayOnce(group)
        let two = Emoji.two.inArrayOnce(group)
        let three = Emoji.three.inArrayOnce(group)
        let four = Emoji.four.inArrayOnce(group)
        return one && two && three && four
    }
    
    
    @IBAction func restart() {
        cell = [
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)]]
        
        populateWithSolution()
        
        for row in 0...3 {
            for col in 0...3 {
                cell[row][col].renderOnButton(buttonMap[row][col]!)
            }
        }
        
    }
    
    @IBAction func presentCustomizeController() {
        self.presentController(withName: "customize", context: self)
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
    
}

























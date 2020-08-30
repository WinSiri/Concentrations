//
//  ViewController.swift
//  Concentrations
//
//  Created by Kwin Sirikwin on 28/4/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : currentTheme.buttonColor
        ]
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!     
    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBAction private func touchCard(_ sender: UIButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            print("chosen card was not in cardButtons")
            return
        }
        flipCount += 1
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        view.backgroundColor = currentTheme.mainViewColor
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.buttonColor
            }
        }
    }
    
    private var themeTable = [
        "Halloween":(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), "🦇😱🙀😈🎃👻🍭🍬🍎"),
        "Animal":(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), "🐷🐼🐵🐔🦄🦊🦁🐤🐝🦀"),
        "Sports":(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), "🏉🏐🏈⚾️🏀🎾⚽️🎱🥊🏓"),
        "Winter":(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "⛄️🌨❄️🥶🎿🏂⛷🧊🎄"),
    ]
    private var emojiTable = [Card:String]()
    private var currentTheme: (mainViewColor: UIColor, buttonColor: UIColor, emojiChoices: String) = (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), "")

    private func getEmoji(for card: Card) -> String {
        if emojiTable[card] == nil, currentTheme.emojiChoices.count > 0 {
            let randomStringIndex = currentTheme.emojiChoices.index(currentTheme.emojiChoices.startIndex, offsetBy: currentTheme.emojiChoices.count.arc4random)
            emojiTable[card] = String(currentTheme.emojiChoices.remove(at: randomStringIndex))
        }
        return emojiTable[card] ?? "?"
    }
        
    @IBAction private func touchNewGame(_ sender: UIButton) {
        game.reset()
        emojiTable.removeAll()
        setNewTheme()
        flipCount = 0
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO Set current theme and view background colour
        setNewTheme()
        updateFlipCountLabel()
        updateViewFromModel()
    }
    
    private func setNewTheme() {
        let themeName = Array(themeTable.keys).randomElement()!
        currentTheme = themeTable[themeName]!
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

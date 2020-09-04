//
//  Displayable.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 03/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

protocol Displayable {
    func addBottomChar(char: String)
    func addTopChar(char: String)
    func bottomText(text: String)
    func topText(text: String)
    func clearDisplay()
    func removeLastInput()
    func moveBotToTop()
    func removeLastTop()
    func clearTop()
}

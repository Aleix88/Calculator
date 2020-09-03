//
//  ButtonsProvider.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

class ButtonsProvider {

    let buttons: [ButtonContent] =
    [
        ButtonContent(content: "C", type: .C),
        ButtonContent(content: "MC", type: .MC),
        ButtonContent(content: "<-", type: .remove, imageName: "delete"),
        ButtonContent(content: "/", type: .divide, imageName: "divide"),
        ButtonContent(content: "7", type: .number),
        ButtonContent(content: "8", type: .number),
        ButtonContent(content: "9", type: .number),
        ButtonContent(content: "*", type: .multiply, imageName: "multiply"),
        ButtonContent(content: "4", type: .number),
        ButtonContent(content: "5", type: .number),
        ButtonContent(content: "6", type: .number),
        ButtonContent(content: "-", type: .substract, imageName: "minus"),
        ButtonContent(content: "1", type: .number),
        ButtonContent(content: "2", type: .number),
        ButtonContent(content: "3", type: .number),
        ButtonContent(content: "+", type: .sum, imageName: "add"),
        ButtonContent(content: "0", type: .number),
        ButtonContent(content: "", type: .empty),
        ButtonContent(content: "", type: .empty),
        ButtonContent(content: "=", type: .equal, imageName: "equal"),
    ]

    
    func buttonAt (_ indexPath: IndexPath) -> ButtonContent {
        return buttons[indexPath.item]
    }
    
    func all() -> [ButtonContent] {
        return buttons
    }
    
}

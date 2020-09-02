//
//  ButtonContent.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

enum ButtonType {
    case number, equal, C, MC, remove, divide, multiply, substract, sum, empty
}

class ButtonContent {
    
    var content: String?
    var type: ButtonType!
    
    init (content: String? = nil, type: ButtonType) {
        self.content = content
        self.type = type
    }
    
}

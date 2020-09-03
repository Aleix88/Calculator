//
//  ButtonContent.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

enum ButtonType {
    case number, equal, C, MC, remove, divide, multiply, substract, sum, empty, point
}

class ButtonContent {
    
    var content: String?
    var type: ButtonType!
    var imageName: String?
    
    init (content: String? = nil, type: ButtonType, imageName: String? = nil) {
        self.content = content
        self.type = type
        self.imageName = imageName
    }
    
}

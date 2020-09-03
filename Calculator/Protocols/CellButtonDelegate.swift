//
//  CellButtonDelegate.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 03/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

protocol CellButtonDelegate {
    func didClickButton (type: ButtonType, content: String?)
}

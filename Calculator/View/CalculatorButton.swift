//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 03/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton, UIInputViewAudioFeedback {
    
    var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed () {
        UIDevice.current.playInputClick()
    }
    
}

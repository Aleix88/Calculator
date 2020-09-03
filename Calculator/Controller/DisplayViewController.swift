//
//  DisplayViewController.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    //MARK: Constants
    
    //MARK: Variables
    
    @IBOutlet weak private var inputLabel: UILabel!
    @IBOutlet weak private var operationLabel: UILabel!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: Displayable
extension DisplayViewController: Displayable {
    func addSymbol(symbol: String, type: ButtonType) {
        if inputLabel.text == nil {
            inputLabel.text = ""
        }
        UIView.transition(with: inputLabel, duration: 0.1, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.inputLabel.text! += symbol
        }, completion: nil)
    }
}


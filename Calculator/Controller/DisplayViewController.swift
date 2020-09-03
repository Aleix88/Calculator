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
    func bottomText(text: String) {
        self.inputLabel.text = text
    }
    
    func topText(text: String) {
        self.operationLabel.text = text
    }
    
    func addBottomChar(char: String) {
        if inputLabel.text == nil {
            inputLabel.text = ""
        }
        
        UIView.transition(with: inputLabel, duration: 0.1, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.inputLabel.text! += char
        }, completion: nil)
    }
    
    func addTopChar(char: String) {
        if ((operationLabel.text ?? "").isEmpty) {
            operationLabel.text = ""
        }
        operationLabel.text! += char
    }
    
    func moveBotToTop() {
        if ((operationLabel.text ?? "").isEmpty) {
            operationLabel.text = ""
        }
        operationLabel.text! += inputLabel.text ?? ""
        inputLabel.text = ""
    }
    
    func clearDisplay() {
        self.inputLabel.text = ""
        self.operationLabel.text = ""
    }
    
    func removeLastInput() {
        self.inputLabel.text = String((self.inputLabel.text ?? "").dropLast())
    }
}


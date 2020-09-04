//
//  MainViewController.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Variables
    private var display: Displayable?
    private var buttonsViewController: ButtonsViewController?
    private var lastResult: String = ""
    private var lastExpression: String = ""
    private var lastSymbolWasOperator = false
    //MARK: Constants
    
    private let calulator = Calculator()
    private let maxNumberLength = 9
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buttonsViewController?.buttonsDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let displayViewController as DisplayViewController:
            self.display = displayViewController as Displayable
        case let buttonsViewController as ButtonsViewController:
            self.buttonsViewController = buttonsViewController
        default:
            break
        }
    }

}

extension MainViewController: CellButtonDelegate {
    
    func clear() {
        self.calulator.clearAll()
        self.display?.clearDisplay()
        self.lastResult = ""
        self.lastExpression = ""
        self.lastSymbolWasOperator = false
    }
    
    func resolve() {
        self.lastSymbolWasOperator = false
        let result = calulator.calculate()
        if (!self.lastResult.isEmpty && !calulator.isOperationSymbol(String(self.lastResult.first!))) {
            self.display?.clearTop()
        }
        if (!self.lastResult.isEmpty && calulator.isOperationSymbol(String(self.lastResult.first!))) {
            self.display?.topText(text: self.lastResult + self.lastExpression)
        } else {
            self.display?.moveBotToTop()
        }
        self.display?.bottomText(text: result)
        self.lastResult = result
    }
    
    func delete() {
        self.lastSymbolWasOperator = false
        self.calulator.deleteLastDigit()
        self.display?.removeLastInput()
    }
    
    func addOperator(operatorSymbol: String) {
        guard !self.lastExpression.isEmpty else {return}
        if (self.lastSymbolWasOperator) {self.display?.removeLastTop()}
        self.lastExpression = ""
        self.lastSymbolWasOperator = true
        self.calulator.addOperationSymbol(symbol: operatorSymbol)
        if (!self.lastResult.isEmpty) {
            self.display?.topText(text: self.lastResult)
            self.display?.bottomText(text: "")
            self.display?.addTopChar(char: operatorSymbol)
            self.lastExpression += operatorSymbol
            self.lastResult = ""
            return
        }
        self.display?.moveBotToTop()
        self.display?.addTopChar(char: operatorSymbol)
        self.lastExpression += operatorSymbol
    }
    
    func addNumber(number: String) {
        guard self.calulator.nextNumberLength() < self.maxNumberLength else {return}
        if number == "." && self.calulator.nextNumberIsDecimal() {return}
        self.lastSymbolWasOperator = false
        self.calulator.addDigit(digit: number)
        self.display?.addBottomChar(char: number)
        self.lastExpression += number
    }
    
    func didClickButton(type: ButtonType, content: String?) {
        guard let content = content else {return}
        switch type {
        case .C:
            clear()
        break
        case .remove:
            delete()
        break
        case .equal:
            resolve()
            break
        case .sum, .divide, .multiply, .substract:
            addOperator(operatorSymbol: content)
        case .MC:
            break
        default:
            addNumber(number: content)
        }
    }
}

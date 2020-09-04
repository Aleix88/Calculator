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
    private var displayViewController: DisplayViewController?
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
            self.displayViewController = displayViewController
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
        self.displayViewController?.clearDisplay()
        self.lastResult = ""
        self.lastSymbolWasOperator = false
    }
    
    func resolve() {
        self.lastSymbolWasOperator = false
        let result = calulator.calculate()
        if (!self.lastResult.isEmpty && !calulator.isOperationSymbol(String(self.lastResult.first!))) {
            self.displayViewController?.clearTop()
        }
        if (!self.lastResult.isEmpty && calulator.isOperationSymbol(String(self.lastResult.first!))) {
            self.displayViewController?.topText(text: self.lastResult + self.lastExpression)
        } else {
            self.displayViewController?.moveBotToTop()
        }
        self.displayViewController?.bottomText(text: result)
        self.lastResult = result
    }
    
    func delete() {
        self.lastSymbolWasOperator = false
        self.calulator.deleteLastDigit()
        self.displayViewController?.removeLastInput()
    }
    
    func addOperator(operatorSymbol: String) {
        if (self.lastSymbolWasOperator) {self.displayViewController?.removeLastTop()}
        self.lastExpression = ""
        self.lastSymbolWasOperator = true
        self.calulator.addOperationSymbol(symbol: operatorSymbol)
        if (!self.lastResult.isEmpty) {
            self.displayViewController?.topText(text: self.lastResult)
            self.displayViewController?.bottomText(text: "")
            self.displayViewController?.addTopChar(char: operatorSymbol)
            self.lastExpression += operatorSymbol
            self.lastResult = ""
            return
        }
        self.displayViewController?.moveBotToTop()
        self.displayViewController?.addTopChar(char: operatorSymbol)
        self.lastExpression += operatorSymbol
    }
    
    func addNumber(number: String) {
        guard self.calulator.nextNumberLength() < self.maxNumberLength else {return}
        if number == "." && self.calulator.nextNumberIsDecimal() {return}
        self.lastSymbolWasOperator = false
        self.calulator.addDigit(digit: number)
        self.displayViewController?.addBottomChar(char: number)
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

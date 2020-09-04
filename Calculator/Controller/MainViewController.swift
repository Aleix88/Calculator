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
    
    func didClickButton(type: ButtonType, content: String?) {
        guard let content = content else {return}
        switch type {
        case .C:
            self.calulator.clearAll()
            self.displayViewController?.clearDisplay()
            self.lastResult = ""
        break
        case .remove:
            self.calulator.deleteLastDigit()
            self.displayViewController?.removeLastInput()
        break
        case .equal:
            let result = calulator.calculate()
            self.displayViewController?.moveBotToTop()
            self.displayViewController?.bottomText(text: result)
            self.lastResult = result
            break
        case .sum, .divide, .multiply, .substract:
            self.calulator.addOperationSymbol(symbol: content)
            if (!self.lastResult.isEmpty) {
                self.displayViewController?.topText(text: self.lastResult)
                self.displayViewController?.bottomText(text: "")
                self.displayViewController?.addTopChar(char: content)
                return
            }
            self.displayViewController?.moveBotToTop()
            self.displayViewController?.addTopChar(char: content)
        default:
            guard self.calulator.nextNumberLength() < self.maxNumberLength else {return}
            if content == "." && self.calulator.nextNumberIsDecimal() {return}
            self.calulator.addDigit(digit: content)
            self.displayViewController?.addBottomChar(char: content)
        }
        print(type, content)
    }
}

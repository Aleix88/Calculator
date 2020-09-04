//
//  Calculator.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 03/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

//MARK: Errors

enum CaculatorError: Error {
    case divByZero, unknownSymbol
}

//MARK: Calculator
class Calculator {
    
    //MARK:Constants
    
    //MARK:Variables
    
    var numericExpression: String = ""
    var nextNumber: String = ""
    
    //MARK: Public Functions
    
    func addDigit(digit: String) {
        guard digit == "." || Int(digit) != nil else {
            return
        }
        if digit == "." && nextNumber.contains(".") {return}
        nextNumber += digit
    }
    
    func deleteLastDigit() {
        guard !nextNumber.isEmpty else {return}
        nextNumber.removeLast()
    }
    
    func addOperationSymbol(symbol: String) {
        guard isOperationSymbol(symbol) else {
            return
        }
        if !numericExpression.isEmpty && String(numericExpression.last!) == symbol && nextNumber.isEmpty {
            numericExpression.removeLast()
            numericExpression += symbol
            return
        }
        numericExpression.append(nextNumber)
        nextNumber = ""
        numericExpression += symbol
    }
    
    func calculate() -> String {
        numericExpression.append(nextNumber)
        let numbers = numericExpression.components(separatedBy: ["+","-","*","/"])
        let symbols = numericExpression.filter({(char) in return Int(String(char)) == nil && char != "."})
        if (numbers.count - 1 != symbols.count) {
            numericExpression.append(String(getMeaninglessNumberFor(symbol: String(symbols.last!))))
        }
        let expression = NSExpression(format: numericExpression)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        clearAll()
        return String(result)
        
    }
    
    func clearAll() {
        numericExpression = ""
        nextNumber = ""
    }
    
    func nextNumberLength() -> Int {
        guard (nextNumber.last != nil) else {return 0}
        return nextNumber.last! == "." ? nextNumber.count - 1 : nextNumber.count
    }
    
    func nextNumberIsDecimal() -> Bool {
        return nextNumber.contains(".")
    }
    
    //MARK: Private functions
    
    private func isOperationSymbol(_ symbol: String) -> Bool {
        return ["+","-","*","/"].contains(symbol)
    }
    
    private func getMeaninglessNumberFor(symbol: String) -> Int {
        let numbers = ["+":0, "-":0, "*":1, "/":1]
        return numbers[symbol] ?? 1
    }
    
}

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
    private let errorResult = "ERROR"
    
    //MARK:Variables
    
    var operationString: String = ""
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
        nextNumber.removeLast()
    }
    
    func addOperationSymbol(symbol: String) {
        guard isOperationSymbol(symbol) else {
            return
        }
        if !operationString.isEmpty && String(operationString.last!) == symbol {
            operationString.removeLast()
            operationString += symbol
            return
        }
        operationString.append(nextNumber)
        nextNumber = ""
        operationString += symbol
    }
    
    func calculate() -> String {
        operationString.append(nextNumber)
        var result: Float = 0.0
        var numbers = operationString.components(separatedBy: ["+","-","*","/"])
        var symbols = operationString.filter({(char) in return Int(String(char)) == nil && char != "."})
        if (numbers.count - 1 != symbols.count) {
            numbers.append(String(getMeaninglessNumberFor(symbol: String(symbols.last!))))
        }
        while numbers.count > 1 {
            let leftRealNumber = Float(numbers[0]) ?? 0
            let rightRealNumber = Float(numbers[1]) ?? 0
            numbers.removeFirst()
            numbers.removeFirst()
            do {
                result = try performOperation(leftNum: leftRealNumber, rightNum: rightRealNumber, symbol: String(symbols.first!))
                numbers.insert(String(result), at: 0)
                symbols.removeFirst()
            } catch {
                clearAll()
                return errorResult
            }
        }
        
        clearAll()
        return String(result)
        
    }
    
    func clearAll() {
        operationString = ""
        nextNumber = ""
    }
    
    //MARK: Private functions
    
    private func isOperationSymbol(_ symbol: String) -> Bool {
        return ["+","-","*","/"].contains(symbol)
    }
    
    private func getMeaninglessNumberFor(symbol: String) -> Int {
        let numbers = ["+":0, "-":0, "*":1, "/":1]
        return numbers[symbol] ?? 1
    }
    
    private func performOperation(leftNum: Float, rightNum: Float, symbol: String) throws -> Float {
        switch symbol {
        case "+":
            return leftNum + rightNum
        case "-":
            return leftNum - rightNum
        case "*":
            return leftNum * rightNum
        case "/":
            if (rightNum == 0) {
                throw CaculatorError.divByZero
            }
            return leftNum / rightNum
        default:
            throw CaculatorError.unknownSymbol
        }
    }
    
}

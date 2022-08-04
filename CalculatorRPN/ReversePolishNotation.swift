//
//  ReversePolishNotation.swift
//  CalculatorRPN
//
//  Created by Алмаз Атабаев on 20/7/22.
//

import Foundation

class ReversePolishNotation {
    func evalRPN(_ tokens: [String]) -> Double {
        var stack = [Double]()
        let operators = "+-/*^%"
        for token in tokens {
            if operators.contains(token) {
                var result = 0.0
                let second = stack.popLast()!
                let first = stack.popLast() ?? 0.0
                switch token {
                case "+":
                    result = first + second
                case "-":
                    result = first - second
                case "*":
                    result = first * second
                case "^":
                    result = sqrt(second)
                case "%":
                    result = second / 100
                default:
                    result = first / second
                }
                stack.append(result)
            }
            else if let value = Double(token){
                stack.append(value)
            }
        }
        return stack[0]
    }
}






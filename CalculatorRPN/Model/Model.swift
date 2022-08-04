//
//  Model.swift
//  CalculatorRPN
//
//  Created by Алмаз Атабаев on 19/7/22.
//

import Foundation

class Model {
    private let viewer: Viewer
    private let rpn: ReversePolishNotation
    
    var displayResult = ""
    var stillTyping = false
    var dotIsPlaced = false
    let OPERANDS = ["*","+","/","-"]
    
    var currentInput: Double {
        get {
            return Double(viewer.getResult())!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResult = "\(valueArray[0])"
            } else{
                displayResult = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    init(viewer: Viewer) {
        self.viewer = viewer
        rpn = ReversePolishNotation()
    }
    
    func clearButtonModel(){
        currentInput = 0
        displayResult = "0"
        stillTyping = false
        dotIsPlaced = false
        
        viewer.clearValues()
        viewer.updateDisplayResultLabel(result: displayResult)
        viewer.updateOperationLabel(displayResult: displayResult)
    }
    
    func calculateEqualityModel()  {
        var tokens: [String] = []
        let exp = Conversion()
        let operations = viewer.getTokens()
        let stringRepresentation = operations.joined(separator:"")
        
        
        tokens =  exp.infixToPostfix(stringRepresentation)
        
        let result = rpn.evalRPN(tokens)
        viewer.updateDisplayResultLabel(result: String(result))
    }
    
    func isDelimeter(operand: String) -> Bool {
        if operand == "=" || operand == " " {
            return true
        }
        return false
    }
    
    func isOperator(operand: String) -> Bool {
        return OPERANDS.contains(operand)
    }
    
    func getPriority(operand: String) -> Int {
        switch operand {
        case "(":
            return 0
        case ")":
            return 1
        case "+":
            return 2
        case "-":
            return 3
        case "*":
            return 4
        case "/":
            return 4
        case "^":
            return 1
        default:
            return 6
        }
    }
    
    func buttonTapped() {
        let number = viewer.getNumberButton()
        if stillTyping {
            if viewer.getResult().count < 20 {
                displayResult = number
            }
        } else {
            displayResult = number
            stillTyping = true
        }
        viewer.updateOperationLabel(displayResult: displayResult)
    }
}




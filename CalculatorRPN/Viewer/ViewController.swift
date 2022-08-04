//
//  ViewController.swift
//  CalculatorRPN
//
//  Created by Алмаз Атабаев on 19/7/22.
//

import UIKit

class Viewer: UIViewController {
    @IBOutlet weak var allOperationsDisplayLabel: UILabel!
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var controller: Controller?
    var numberButton: String = ""
    var buttonCurrentTitle = ""
    var tokens: [String] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        controller = Controller(viewer: self)
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func allOperations(_ sender: UIButton) {
        for number in 0...9 {
            if sender.tag == number {
                numberButton += "\(number)"
                tokens.append(String(number))
                controller?.buttonTapped()
            }
        }
        
        for operation in 11...19 {
            if sender.tag == operation {
                if let currentTitle = sender.currentTitle {
                    numberButton += currentTitle
                    tokens.append(currentTitle)
                    controller?.buttonTapped()
                }
            }
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        controller?.clearButtonController()
    }
    
    @IBAction func resultButton(_ sender: UIButton) {
        controller?.resultTapped()
    }
    
    func getResult() -> String {
        return allOperationsDisplayLabel.text ?? ""
    }
    
    func updateOperationLabel(displayResult: String) {
        allOperationsDisplayLabel.text! = displayResult
    }
    
    func updateDisplayResultLabel(result: String) {
        displayResultLabel.text = result
    }
    
    func getButtonCurrentTitle() -> String {
        return buttonCurrentTitle
    }
    
    func getNumberButton() -> String {
        return numberButton
    }
    
    func getTokens() -> [String] {
        return tokens
    }
    
    func clearValues() {
        numberButton = ""
        buttonCurrentTitle = ""
        tokens = []
    }
}

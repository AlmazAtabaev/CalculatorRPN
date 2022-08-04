//
//  Controller.swift
//  CalculatorRPN
//
//  Created by Алмаз Атабаев on 19/7/22.
//

import UIKit

class Controller {
    
    
    let model: Model
    
    init(viewer: Viewer) {
        model = Model(viewer:viewer)
    }
    
    func allOperationsController(){
        model.calculateEqualityModel()
    }
    
    func clearButtonController(){
        model.clearButtonModel()
    }

    func buttonTapped() {
        model.buttonTapped()
    }

    func resultTapped() {
        model.calculateEqualityModel()
    }
}


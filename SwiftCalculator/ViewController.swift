//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Yauheni Bunas on 5/18/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let maximumInputNumberCount:Int = 30
    
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTypping: Bool = false
    var dotIsPlaced: Bool = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let newValue = "\(newValue)"
            let newValueArray = newValue.components(separatedBy: ".")
            if newValueArray[1] == "0" {
                displayResultLabel.text = "\(newValueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            stillTypping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if (stillTypping) {
            if displayResultLabel.text!.count < self.maximumInputNumberCount {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            stillTypping = true
            displayResultLabel.text = number
        }
        
    }
     
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTypping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTypping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if (stillTypping) {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
            case "+":
                operateWithTwoOperands{$0 + $1}
            case "-":
                operateWithTwoOperands{$0 - $1}
            case "÷":
                operateWithTwoOperands{$0 / $1}
            case "×":
                operateWithTwoOperands{$0 * $1}
            default: break
        }
        
    }
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        operationSign = ""
        displayResultLabel.text = "0"
        stillTypping = false
        dotIsPlaced = false
    }
    
    @IBAction func percentageButtonAction(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func plusMinusButtonAction(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func dotButtonAction(_ sender: UIButton) {
        if stillTypping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTypping && !dotIsPlaced{
            displayResultLabel.text = "0."
        }
    }
}


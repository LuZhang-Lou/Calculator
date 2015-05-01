//
//  ViewController.swift
//  CalculatorDemo
//
//  Created by 张璐 on 4/30/15.
//  Copyright (c) 2015 BUPT. All rights reserved.
//

import UIKit

class ViewController : UIViewController  {
    
    
    @IBOutlet weak var display: UILabel!
  
  //heihei
    var  userIsInTheMIddleOfTyping  = false
    
    @IBAction func appendDigit(sender: UIButton) {
        // 如果 sender是anyObject,则取值用的digit都要变成digit!
        let digit = sender.currentTitle!
        println("digit is \(digit)");
        if userIsInTheMIddleOfTyping{
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMIddleOfTyping = true
        }
    }
    
    var operandStack = Array<Double>()
    
    
    
    
    @IBAction func enter() {
        userIsInTheMIddleOfTyping = false;
        operandStack.append(digitValue)
        println("\(operandStack)")
    }
    
    var digitValue : Double  {
        get{
            // need no useIsin ... ?
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMIddleOfTyping = false;
        }
    }
    
    
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if (userIsInTheMIddleOfTyping){
            enter()
        }
        
        switch operation{
        case "×":  performOperation( {  $1 * $0 })
        case "+":  performOperation( {  $1 + $0 }) // 注意：传的是方法，而不是方法的参数。参数在performOpe..这个方法指定
        case "−":  performOperation( {  $1 - $0 })
        case "÷":  performOperation( {  $1 / $0 })
        case "√":  performOperation( {  sqrt($0)})
        default : break
        }
        
    }
    //    func multiply(op1 : Double, o√p2 : Double)-> Double{
    //        return op1 * op2
    //    }
    
    func performOperation(operation: (Double,Double)-> Double) {
        if operandStack.count >= 2 {
            digitValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double-> Double) {
        if operandStack.count >= 1 {
            digitValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
}


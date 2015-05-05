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
  
    var  userIsInTheMIddleOfTyping  = false
    
    var brain = CalculatorBrain()
    
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
    
    //fucvar operandStack = Array<Double>()
    
 
    @IBAction func enter() {
        userIsInTheMIddleOfTyping = false;
        /*
        operandStack.append(digitValue)
        println("\(operandStack)")*/
        
        if let result = brain.pushOperand(digitValue){
            digitValue = result
        } else {
            digitValue = 0
        }
    }
    
    var digitValue : Double  { // note, it's : not =
        get{
            // need no useIsin  ... ?
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMIddleOfTyping = false;
        }
    }
    
    
    
    
    @IBAction func operate(sender: UIButton) {
        
        if (userIsInTheMIddleOfTyping){
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
                digitValue = result;
            } else {
                digitValue = 0
            }
            
        }
        
        /*if let operation = sender.currentTitle{
            switch operation{
            case "×":  performOperation( * )
            case "+":  performOperation( { $1 + $0} ) // 注意：传的是方法，而不是方法的参数。参数在performOpe..这个方法指定
            case "−":  performOperation( {  $1 - $0 })
            case "÷":  performOperation( {  $1 / $0 })
            case "√":  performOperation( sqrt )
            default : break
            }
        }*/
        
    }
    
    //    func multiply(op1 : Double, op2 : Double)-> Double{
    //        return op1 * op2
    //    }
    
    /*func performOperation(operation: (Double,Double)-> Double) {
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
    }*/
    
}


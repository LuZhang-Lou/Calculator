//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 张璐 on 5/5/15.
//  Copyright (c) 2015 BUPT. All rights reserved.
//
// Array<Op> == [Op]
// Dictionary<String, Op> = [String: Op]

import Foundation

class CalculatorBrain{
    
    private enum Op: Printable{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String{ // it has to be named description
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _) :
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    private var knownOps =  [String: Op]()
    
    
    private var opStack = [Op]()
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
        
    }
    func performOperation(symbol : String) -> Double?{
        // let operation = knownOps[symbol], in there operation is op?
        if let operation = knownOps[symbol] { // here, operation is op
            opStack.append(operation)    // operation is op
        }
        return evaluate()
    }
    
    private func evaluate( ops: [Op]) -> (result : Double?, remainingOps: [Op]) // before argument : let. var !!
    {
        if  !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):  // can't code like op.Operand
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
        
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
            
    
    
    init() {
        func learnOp(op: Op){
            knownOps[op.description] = op;
        }
        learnOp(Op.BinaryOperation("×", *))
      //  knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("-", {$1 - $0})
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
}

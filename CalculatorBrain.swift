//
//  CalculatorBrain.swift
//  Calculator
//
//
//
//
//  Created by Adele Kufour on 26/12/2017.
//  Copyright © 2017 VenturesWithAd. All rights reserved.
//

import Foundation

//func changeSign(operand: Double) -> Double {
  //  return -operand
//}

//func multiply(op1: Double, op2: Double) -> Double {
//    return op1 * op2
//}

struct CalculatorBrain {
    
    private var accumulator: Double? // private for internal implementations
    
    private enum Operation {
        case constant(Double) // can have multiple in arguments
        case unaryOperation((Double) -> Double) //function that takes a double and returns one
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
    "pi" : Operation.constant(Double.pi),
    "e" : Operation.constant(M_E),
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "⏧" : Operation.unaryOperation({ -$0 }),
    "x" : Operation.binaryOperation({ $0 * $1 }),
    "/" : Operation.binaryOperation({ $0 / $1 }),
    "+" : Operation.binaryOperation({ $0 + $1 }),
    "-" : Operation.binaryOperation({ $0 - $1 }),
    "=" : Operation.equals
    
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil { //another way to do an if let statement check
                    accumulator = function(accumulator!)
                    break
                }//end if
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
                break
            }//end switch
        }//end if let
    }//end function
    
    private mutating func performPendingBinaryOperation() { //changing the accumulator
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    
     mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
   
    var result: Double? {
        get { //makes it read only
            return accumulator
        }
    }
   
    
    
}










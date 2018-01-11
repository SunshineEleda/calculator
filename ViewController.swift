//
//  ViewController.swift
//  Calculator
//
//  Created by Adele Kufour on 07/12/2017.
//  Copyright © 2017 VenturesWithAd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel! //automatic unwrapping
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle! //! means unwrap this thing and give me the associated value
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text
            display.text = textCurrentlyInDisplay! + digit
            
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue: Double { // computed value
        get {
           return Double(display.text!)!
        }
        set{
           display.text! = String(newValue)
        }
    }
    
    //model always private to the controller
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        //1. if in the middle of typing a number, need to set it as an operand
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }//end if

        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }//end if let
        
        if let result = brain.result {
            displayValue = result
        }
    }//end method
    
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/

}


//
//  ViewController.swift
//  Wage Calculator
//
//  Created by Santiago Hernandez on 2/21/22.
//

import UIKit

class ViewController: UIViewController {

  //Input Parameters IBOutlets
    
    @IBOutlet weak var FirstNameInput: UITextField!
    
    @IBOutlet weak var LastNameInput: UITextField!
    
    @IBOutlet weak var HoursWorkedInput: UITextField!
    
    @IBOutlet weak var AppleCertifiedSwitch: UISwitch!
    
    //Output UILabel
    
    @IBOutlet weak var OutputLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func CalculateButtonEvent(_ sender: UIButton) {
        
        //Check all fields are filled
        if FirstNameInput.hasText && LastNameInput.hasText && HoursWorkedInput.hasText {
            performCalculation()
        } else {
            OutputLabel.text = "Please fill all fields"
            OutputLabel.isHidden = false
        }
        
    }
    func performCalculation() {
        //Declare variables from name fields and hours worked
        let firstName: String = FirstNameInput.text!
        let lastName: String = LastNameInput.text!
        var hoursWorked:Float = Float(HoursWorkedInput.text!)!

        //Output Variable
        var finalWage: Float = 0.00
        
//        Parameters:
//        1) The base hourly rate for the consultant is $100 per hour.
//        2) If a consultant has the Apple certification (using an UISwitch element), his or her base rate will be 20% more than the normal base rate.
//        3) If a consultant works for more than 40 hours a week, any hours beyond the 40 hours should be counted as overtime and will be paid 50% more than the base rate (i.e., 1.5 ratio of the base rate).

        //Parameter #1.
        var hourlyRate: Float = 100.00
        
        //Parameter #2.
        var baseRateModifier: Float = 1.00
        
        if AppleCertifiedSwitch.isOn {
            baseRateModifier += 0.20
        }
        
        //Apply baseRateModifier to hourlyRate
        hourlyRate = hourlyRate * baseRateModifier
        
        //Parameter #3.
        let fullTime: Float = 40.00
        
        while hoursWorked > 0 {
            //Logic gate updates wage for each hour worked with a 50% increase in hourly rate for overtime hours.
            if hoursWorked <= fullTime {
                finalWage += hourlyRate
            } else {
                finalWage += hourlyRate * 1.50
            }
            hoursWorked -= 1.00
        }
        
        //Convert to currency
        //Adapted from https://supereasyapps.com/blog/2016/2/8/how-to-use-nsnumberformatter-in-swift-to-make-currency-numbers-easy-to-read
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to US dollars
        currencyFormatter.locale = Locale(identifier: "en_US")
        
        let finalWageUSD = currencyFormatter.string(from: NSNumber(value: finalWage))!
        
        //Display result in OutputLabel
        OutputLabel.text = "Thank you, \(firstName) \(lastName) for using the mobile wage calculator! Your weekly salary is \(finalWageUSD)."
        OutputLabel.isHidden = false
        
    }
    
    
    @IBAction func ClearButtonEvent(_ sender: UIButton) {
        //Empty all cells
        
        FirstNameInput.text = ""
        LastNameInput.text = ""
        HoursWorkedInput.text = ""
        OutputLabel.text = ""
        
        //Turn Apple certified switch off
        AppleCertifiedSwitch.isOn = false
    }
}


//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Kashyap Sodha on 2/15/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else{
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController is loaded")
        updateCelsiusLabel()
    }
}
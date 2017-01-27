//
//  PhoneInputDelegate.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/27/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class PhoneInputDelegate: NSObject, UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 0 && Int(string) == nil {
            return false
        }
        let delta = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        var numbers = delta.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

        var formattedNumber = "1-"
        var idx = 0
        if numbers[0] == "1" {
            numbers.remove(at: 0)
        }
        if numbers.count > 2 {
            formattedNumber.append("(")
            for subIdx in 0...2 {
                formattedNumber.append(String(numbers[subIdx]))
            }
            formattedNumber.append(")")
        }
        else {
            formattedNumber.append(string)
        }
        textField.text = formattedNumber
        /*var phone = textField.text ?? ""
        var formattedNumber = ""
        if phone.characters.count == 0 {
            formattedNumber = string != "1" ? "1-\(string)" : string
        }
        else if phone.characters.count == 4 {
            formattedNumber = "1-(\(string))"
        }
        textField.text = formattedNumber*/
        return false
    }

}

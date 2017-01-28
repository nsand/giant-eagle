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
            // It isn't a number
            return false
        }
print(textField.text!)
        let delta = (textField.text! as NSString).replacingCharacters(in: range, with: string)
print(delta)
        var numbers = delta.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        numbers = numbers.filter({ $0.characters.count > 0 })
        print(numbers)
        var formattedNumber = "1-"
        var idx = 0
        if numbers[0] == "1" {
            numbers.remove(at: 0)
        }
        if numbers.count > 0 {
            // Area code is there
            if numbers[0].characters.count == 3 {
                formattedNumber.append("(\(numbers[0]))")
            }
            else {
                formattedNumber.append(numbers[0])
            }
        }
        if numbers.count > 1 {
            formattedNumber.append(" \(numbers[1])\(numbers[1].characters.count == 3 ? "-" : "")")
        }
        if numbers.count > 2 {
            formattedNumber.append(numbers[2])
        }

        /*else {
            formattedNumber.append(string)
        }*/
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

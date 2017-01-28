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

        let current = textField.text!
        var delta = (current as NSString).replacingCharacters(in: range, with: string)

        if delta.characters.count > 2 && delta.characters.count < current.characters.count {
            // If the character that is being replaced is a separator, remove the previous number
            let toReplace = (current as NSString).substring(with: range)
            if toReplace == "-" || toReplace == ")" {
                delta.remove(at: delta.index(delta.endIndex, offsetBy: -1))
            }
        }
        // Find the actual numbers in the text, split up by separators
        var numbers = delta.components(separatedBy: NSCharacterSet.decimalDigits.inverted).filter({ $0.characters.count > 0 })

        // Always start with 1-
        var formattedNumber = "1-"

        if numbers[0] == "1" {
            // If the first bit is a 1, it's taken care of by the above
            numbers.remove(at: 0)
        }
        if numbers.count > 0 {
            // The starts of an area code was specified
            if numbers[0].characters.count == 3 {
                formattedNumber.append("(\(numbers[0]))")
            }
            else {
                formattedNumber.append(numbers[0])
            }
        }
        if numbers.count > 1 {
            // First three digits of the phone number
            formattedNumber.append("-\(numbers[1])\(numbers[1].characters.count == 3 ? "-" : "")")
        }
        if numbers.count > 2 {
            // Last four digits of the phone number
            var endDigits = numbers[2]
            if let endIdx = numbers[2].index(numbers[2].startIndex, offsetBy: 4, limitedBy: numbers[2].endIndex) {
                endDigits = endDigits.substring(to: endIdx)
            }
            formattedNumber.append(endDigits)
        }

        // Update the textfield with the formatted phone number
        textField.text = formattedNumber

        return false
    }

}

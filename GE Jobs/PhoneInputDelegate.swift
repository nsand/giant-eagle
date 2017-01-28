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

        let delta = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        var numbers = delta.components(separatedBy: NSCharacterSet.decimalDigits.inverted).filter({ $0.characters.count > 0 })

        var formattedNumber = "1-"

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
            formattedNumber.append("-\(numbers[1])\(numbers[1].characters.count == 3 ? "-" : "")")
        }
        if numbers.count > 2 {
            var endDigits = numbers[2]
            if let endIdx = numbers[2].index(numbers[2].startIndex, offsetBy: 4, limitedBy: numbers[2].endIndex) {
                endDigits = endDigits.substring(to: endIdx)
            }
            formattedNumber.append(endDigits)
        }

        textField.text = formattedNumber

        return false
    }

}

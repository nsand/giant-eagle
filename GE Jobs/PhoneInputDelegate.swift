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
        return true
    }

}

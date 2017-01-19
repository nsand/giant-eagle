//
//  Email.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/18/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import Foundation

class Email {
    static var template: String? {
        if let path = Bundle.main.path(forResource: "email", ofType: "tpl") {
            return try? String(contentsOfFile: path, encoding: .utf8);
        }
        return nil;
    }
    func send(_ variables: [String: String]) {
        // Use NSRegularExpression with .matches to get the ranges of matches, find the string in the range, look up that string in the variables dictionary
        print(Email.template!);
    }
}

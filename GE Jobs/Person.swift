//
//  Person.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/22/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import Foundation

class Person {
    var name: String?
    var phone: String?
    var isOver18: Bool?
    var departments = [String]()
    var availability : [String: [String]] = [
        "Monday": [],
        "Tuesday": [],
        "Wednesday": [],
        "Thursday": [],
        "Friday": [],
        "Saturday": [],
        "Sunday": []
    ]

    func isValid() -> Bool {
        if let _name = name, let _phone = phone {
            return _name.characters.count > 0 && _phone.characters.count == 16 && isOver18 != nil
        }
        return false
    }

    func asDictionary() -> [String : Any] {
        var json : [String : [String : Any]] = [
            "person": [
                "name": name ?? "Han Solo",
                "phone": phone ?? "555-5555",
                "isOver18": isOver18 != nil ? (isOver18! ? "Yes" : "No") : "Answer Not Provided",
                "departments": departments.joined(separator: ", ")
            ]
        ]
        var personalAvailability = [String : String]()
        for (day, availabilities) in availability {
            personalAvailability[day] = availabilities.joined(separator: "/")
        }
        json["person"]?["availability"] = personalAvailability
        return json
    }
}

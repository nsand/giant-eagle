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
    var isOver18 = false
    var departments = [String]()
    var availability : [String: [String]] = [
        "monday": [],
        "tuesday": [],
        "wednesday": [],
        "thursday": [],
        "friday": [],
        "saturday": [],
        "sunday": []
    ]

    func asDictionary() -> [String : Any] {
        var json : [String : [String : Any]] = [
            "person": [
                "name": name ?? "Han Solo",
                "phone": phone ?? "555-5555",
                "isOver18": isOver18 ? "Yes": "No",
                "departments": departments.joined(separator: ", ")
            ]
        ]
        var personalAvailability = [String : String]()
        for day in availability.keys {
            personalAvailability[day] = self.availability[day]?.joined(separator: "/")
        }
        json["person"]?["availability"] = personalAvailability
        return json
    }
}

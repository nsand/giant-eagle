//
//  AvailabilityDataSource.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/29/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class AvailabilityDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    enum Days: String {
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }
    let SHIFTS = ["Morning", "Daytime", "Night"]
    var AVAILABILITIES = [
        Days.Monday: [Bool](repeating: false, count: 3),
        Days.Tuesday: [Bool](repeating: false, count: 3),
        Days.Wednesday: [Bool](repeating: false, count: 3),
        Days.Thursday: [Bool](repeating: false, count: 3),
        Days.Friday: [Bool](repeating: false, count: 3),
        Days.Saturday: [Bool](repeating: false, count: 3),
        Days.Sunday: [Bool](repeating: false, count: 3)
    ]
    var activeDay: Days?

    func availability(_ forDay: Days) -> [String] {
        var result = [String]()
        for i in 0..<3 {
            if AVAILABILITIES[forDay]![i] {
                result.append(SHIFTS[i])
            }
        }
        return result
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SHIFTS.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath);
        cell.textLabel?.text = SHIFTS[indexPath.row]
        if let day = activeDay {
            cell.accessoryType = AVAILABILITIES[day]![indexPath.row] ? .checkmark : .none;
        }
        
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let day = activeDay {
            AVAILABILITIES[day]![indexPath.row] = !AVAILABILITIES[day]![indexPath.row]
            tableView.cellForRow(at: indexPath)?.accessoryType = AVAILABILITIES[day]![indexPath.row] ? .checkmark : .none
        }
    }
}

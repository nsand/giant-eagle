//
//  DepartmentDataSource.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/15/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

struct Department {
    var name: String
    var chosen = false
    init(_ name: String) {
        self.name = name;
    }
    init(_ name: String, _ chosen: Bool) {
        self.name = name;
        self.chosen = chosen;
    }
}

class DepartmentDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var DEPARTMENTS = [
        Department("Bakery"),
        Department("Cashier"),
        Department("Deli"),
        Department("Eagle's Nest"),
        Department("Grocery"),
        Department("Management"),
        Department("Meat"),
        Department("Prepared Foods"),
        Department("Produce"),
        Department("Starbucks")
    ];

    var selected: [String] {
        get {
            var departments = [String]();
            for dept in DEPARTMENTS {
                if dept.chosen {
                    departments.append(dept.name);
                }
            }
            return departments;
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DEPARTMENTS.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath);
        let dept = self.DEPARTMENTS[indexPath.row];
        cell.textLabel?.text = dept.name;
        cell.accessoryType = dept.chosen ? .checkmark : .none;
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.DEPARTMENTS[indexPath.row].chosen = !self.DEPARTMENTS[indexPath.row].chosen;
        tableView.cellForRow(at: indexPath)?.accessoryType = self.DEPARTMENTS[indexPath.row].chosen ? .checkmark : .none;
    }

}

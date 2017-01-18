//
//  DepartmentsController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class DepartmentsController: UITableViewController {
    var ds: DepartmentDataSource?;

    override func loadView() {
        super.loadView();
        navigationItem.title = "Departments";

        tableView.dataSource = ds;
        tableView.delegate = ds;
    }
}

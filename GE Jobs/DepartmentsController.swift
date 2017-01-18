//
//  DepartmentsController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class DepartmentsController: UITableViewController, UINavigationControllerDelegate {
    var ds: DepartmentDataSource?;

    override func loadView() {
        super.loadView();

        navigationController?.delegate = self;

        navigationItem.title = "Departments";

        tableView.dataSource = ds;
        tableView.delegate = ds;
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let aboutController = viewController as? AboutYouController {
            aboutController.updateDepartments();
        }
    }
}

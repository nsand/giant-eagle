//
//  DepartmentsController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class DepartmentsController: UITableViewController {
    override func loadView() {
        super.loadView();
        navigationItem.title = "Departments";
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done));
        navigationItem.rightBarButtonItem?.tintColor = .white;
    }
    func done() {
        
    }
    func cancel() {
        
    }
}

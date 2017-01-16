//
//  JobApplicationController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/15/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class JobApplicationController: UIViewController {

    var departmentDataSource: DepartmentDataSource?;

    override func viewDidLoad() {
        super.viewDidLoad();
        if birthday != nil {
            birthday.date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date();
            birthday.maximumDate = Date();
        }
        if departments != nil {
            self.departmentDataSource = DepartmentDataSource();
            departments.dataSource = self.departmentDataSource!;
            departments.delegate = self.departmentDataSource;
        }
    }

    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var departments: UITableView!
}

//
//  AboutYouController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class AboutYouController: UITableViewController {
    var departmentDataSource: DepartmentDataSource = DepartmentDataSource();

    @IBOutlet weak var departmentList: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(done));
        navigationItem.rightBarButtonItem?.tintColor = .white;
        //navigationItem.rightBarButtonItem?.isEnabled = false;
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel));
        navigationItem.leftBarButtonItem?.tintColor = .white;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Application", style: .plain, target: self, action: #selector(cancel));
        navigationController?.navigationBar.tintColor = .white;
    }

    func done() {
        print("Done!");
        let e = Email();
        let person : [String : Any] = [
            "person": [
                "name": "Han Solo",
                "phone": "910-555-0000",
                "isOver18": "Yes",
                "departments": "Deli, Grocery",
                "availability": [
                    "monday": "AM/PM",
                    "tuesday": "AM/PM",
                    "wednesday": "PM",
                    "thursday": "PM",
                    "friday": "AM/PM",
                    "saturday": "-",
                    "sunday": "-"
                ]
            ]
        ]
        e.send(person, done: { (data, response, error) in
            if data != nil {
                if let resp = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
                  print(resp)  
                }
            }
        });
    }

    func cancel() {
        self.performSegue(withIdentifier: "cancelApplicationSegue", sender: self);
        // navigationController?.pushViewController(DepartmentsController(), animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        if let destination = segue.destination as? DepartmentsController {
            // Add the department datasource to the department controller
            destination.ds = departmentDataSource;
        }
    }

    func updateDepartments() {
        departmentList.text = departmentDataSource.selected.joined(separator: ", ");
    }
}

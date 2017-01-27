//
//  AboutYouController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class AboutYouController: UITableViewController, UITextFieldDelegate {

    var person: Person!
    var departmentDataSource: DepartmentDataSource = DepartmentDataSource()

    @IBOutlet weak var departmentList: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var over18: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad();
        person = Person()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(done));
        navigationItem.rightBarButtonItem?.tintColor = .white;
        //navigationItem.rightBarButtonItem?.isEnabled = false;
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel));
        navigationItem.leftBarButtonItem?.tintColor = .white;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Application", style: .plain, target: self, action: #selector(cancel));
        navigationController?.navigationBar.tintColor = .white;
        over18.selectedSegmentIndex = UISegmentedControlNoSegment
        name.delegate = self
        phone.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let value = (textField.text as? NSString)?.replacingCharacters(in: range, with: string) {
            switch textField {
            case name:
                person.name = value
            case phone:
                person.phone = value
            default:
                print("Unknown field")
            }
        }
        return true
    }

    @IBAction func onOver18Change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                person.isOver18 = true
            case 1:
                person.isOver18 = false
            default:
                person.isOver18 = nil
        }
    }

    func done() {
        person.availability["monday"] = ["AM", "PM"]
        person.availability["tuesday"] = ["AM"]
        print(self.person.asDictionary())
        // let e = Email();
        /*
        e.send(person.asDictionary(), done: { (data, response, error) in
            if data != nil {
                if let resp = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
                  print(resp)  
                }
            }
        });
        */
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
        person?.departments = departmentDataSource.selected
    }
}

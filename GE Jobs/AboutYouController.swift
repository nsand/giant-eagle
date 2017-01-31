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
    var departmentDataSource = DepartmentDataSource()
    var availabilityDataSource = AvailabilityDataSource()
    let phoneDelegate = PhoneInputDelegate()

    let DAYS = [
        AvailabilityDataSource.Days.Monday,
        AvailabilityDataSource.Days.Tuesday,
        AvailabilityDataSource.Days.Wednesday,
        AvailabilityDataSource.Days.Thursday,
        AvailabilityDataSource.Days.Friday,
        AvailabilityDataSource.Days.Saturday,
        AvailabilityDataSource.Days.Sunday
    ]

    @IBOutlet weak var departmentList: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var over18: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad();
        person = Person()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(done));
        navigationItem.rightBarButtonItem?.tintColor = .white;
        navigationItem.rightBarButtonItem?.isEnabled = false;
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel));
        navigationItem.leftBarButtonItem?.tintColor = .white;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Application", style: .plain, target: self, action: #selector(cancel));
        navigationController?.navigationBar.tintColor = .white;
        over18.selectedSegmentIndex = UISegmentedControlNoSegment
        name.delegate = self
        phone.delegate = self
        // Update the availabilities to clear out the details text
    }

    func validate() {
        navigationItem.rightBarButtonItem?.isEnabled = person.isValid()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldUpdate = true
        let value = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        switch textField {
            case name:
                person.name = value
            case phone:
                shouldUpdate = phoneDelegate.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
                person.phone = textField.text
            default:
                print("Unknown field")
        }
        validate()
        return shouldUpdate
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
        validate()
    }

    func done() {
        self.performSegue(withIdentifier: "submissionSegue", sender: self)
        /*
        let e = Email();        
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
            destination.ds = departmentDataSource
        }
        if let destination = segue.destination as? AvailabilityController {
            if let cell = sender as? UITableViewCell {
                if let path = tableView.indexPath(for: cell) {
                    availabilityDataSource.activeDay = path.row < DAYS.count ? DAYS[path.row] : nil
                }

            }
            destination.ds = availabilityDataSource
        }
        if let destination = segue.destination as? SubmissionController {
            destination.person = person
        }
    }

    func updateDepartments() {
        var departments = departmentDataSource.selected.joined(separator: ", ")
        if departmentDataSource.selected.count > 3 {
            // If there are more than 3 departments, show the first 3 and how many more are selected
            departments = "\(departmentDataSource.selected.prefix(upTo: 3).joined(separator: ", ")) and \(departmentDataSource.selected.count - 3) more"
        }

        departmentList.text = departments
        person.departments = departmentDataSource.selected
    }

    func updateAvailabilities() {
        for i in 0..<DAYS.count {
            let availability = availabilityDataSource.availability(DAYS[i])
            tableView.cellForRow(at: IndexPath(row: i, section: 2))?.detailTextLabel?.text = availability.count > 0 ? availability.joined(separator: ", ") : " "
            person.availability[DAYS[i].rawValue.lowercased()] = availability
        }
    }

}

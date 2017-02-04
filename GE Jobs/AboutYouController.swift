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
        // Hides the extra blank rows in the table
        tableView.tableFooterView = UIView()
    }

    func validate() {
        // Check if the person's state is valid before enabling the Apply button
        navigationItem.rightBarButtonItem?.isEnabled = person.isValid()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Update the person object based on which field is being typed into
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
        // Toggle the peson's over 18 status
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
        // Move to the submission page, which will email the application
        self.performSegue(withIdentifier: "submissionSegue", sender: self)
    }

    func cancel() {
        // Cancels the application
        self.performSegue(withIdentifier: "cancelApplicationSegue", sender: self);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        if let destination = segue.destination as? DepartmentsController {
            // Add the department datasource to the department controller
            destination.ds = departmentDataSource
        }
        if let destination = segue.destination as? AvailabilityController {
            // When tapping a table view cell, make sure we know which day was tapped
            if let cell = sender as? UITableViewCell {
                if let path = tableView.indexPath(for: cell) {
                    availabilityDataSource.activeDay = path.row < DAYS.count ? DAYS[path.row] : nil
                }

            }
            destination.ds = availabilityDataSource
        }
        if let destination = segue.destination as? SubmissionController {
            // Going to submit the application, let it know about the person
            destination.person = person
        }
    }

    func updateDepartments() {
        // Called when coming back from the departments view
        var departments = departmentDataSource.selected.joined(separator: ", ")
        if departmentDataSource.selected.count > 3 {
            // If there are more than 3 departments, show the first 3 and how many more are selected
            departments = "\(departmentDataSource.selected.prefix(upTo: 3).joined(separator: ", ")) and \(departmentDataSource.selected.count - 3) more"
        }

        departmentList.text = departments
        person.departments = departmentDataSource.selected
    }

    func updateAvailabilities() {
        // Called when coming back from the availability view
        for i in 0..<DAYS.count {
            let availability = availabilityDataSource.availability(DAYS[i])
            tableView.cellForRow(at: IndexPath(row: i, section: 2))?.detailTextLabel?.text = availability.count > 0 ? availability.joined(separator: ", ") : " "
            person.availability[DAYS[i].rawValue.lowercased()] = availability
        }
    }

}

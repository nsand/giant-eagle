//
//  AvailabilityController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/29/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class AvailabilityController: UITableViewController, UINavigationControllerDelegate {
    var ds: AvailabilityDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        navigationItem.title = "Availability"

        tableView.dataSource = ds
        tableView.delegate = ds
        tableView.tableFooterView = UIView()
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let aboutController = viewController as? AboutYouController {
            aboutController.updateAvailabilities();
        }
    }
}

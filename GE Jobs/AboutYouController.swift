//
//  AboutYouController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/16/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class AboutYouController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(done));
        navigationItem.rightBarButtonItem?.tintColor = .white;
        navigationItem.rightBarButtonItem?.isEnabled = false;
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel));
        navigationItem.leftBarButtonItem?.tintColor = .white;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Application", style: .plain, target: self, action: #selector(cancel));
        navigationController?.navigationBar.tintColor = .white;
    }

    func done() {
        print("Done!");
    }

    func cancel() {
        self.performSegue(withIdentifier: "cancelApplicationSegue", sender: self);
        // navigationController?.pushViewController(DepartmentsController(), animated: true)
    }

}

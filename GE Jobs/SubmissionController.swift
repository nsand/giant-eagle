//
//  SubmissionController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/30/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class SubmissionController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var submissionStatus: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var retry: UIButton!

    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        submitApplication()
    }

    @IBAction func onRetry(_ sender: UIButton) {
        submitApplication()
    }

    func submitApplication() {
        retry.isHidden = true
        spinner.startAnimating()
        if let person = self.person {
            let e = Email();
            e.send(person.asDictionary(), done: { (data, response, error) in
                DispatchQueue.main.async(execute: {
                    self.spinner.stopAnimating()
                    if error != nil {
                        self.retry.isHidden = false
                        self.submissionStatus.text = "Something went wrong submitting your application."
                    }
                    else {
                        self.submissionStatus.text = "That's it! Your application has been submitted. We'll contact you soon."
                        if data != nil {
                            if let resp = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
                                print(resp)
                            }
                        }
                        Timer.scheduledTimer(withTimeInterval: 10, repeats: false, block: { (timer) in
                            self.performSegue(withIdentifier: "resetApplicationSegue", sender: self)
                        })
                    }
                })
            })
        }
    }
}

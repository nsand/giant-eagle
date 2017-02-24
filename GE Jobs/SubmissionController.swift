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

    func submissionComplete(_ data: Data?) {
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

    func submitApplication() {
        // When the user submits an application, show a spinner
        retry.isHidden = true
        spinner.startAnimating()
        if let person = self.person {
            // Send off the email using the person's info. When it's done, give status and go back to the landing page
            let e = Email();
            e.send(person.asDictionary(), done: { (data, response, error) in
                DispatchQueue.main.async(execute: {
                    self.spinner.stopAnimating()
                    if error != nil {
                        if data != nil {
                            // This seems to be the case when the service responds with an error
                            self.retry.isHidden = false
                            self.submissionStatus.text = "Something went wrong submitting your application."
                        }
                        else {
                            // Probably a network error
                            Email.queue(person)
                            self.submissionComplete(nil)
                        }
                    }
                    else {
                        self.submissionComplete(data)
                    }
                })
            })
        }
    }
}

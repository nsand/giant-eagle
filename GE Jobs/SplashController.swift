//
//  SplashController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/15/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class SplashController : UIViewController {

    var brightness: CGFloat = 1;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.brightness = UIScreen.main.brightness;
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {(timer) in
            UIScreen.main.brightness = 0.7;
        });
    }
    @IBAction func startTap(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "jobApplicationSegue", sender: self);
    }
}

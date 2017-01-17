//
//  SplashController.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/15/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import UIKit

class SplashController : UIViewController {

    private var brightness: CGFloat = 1;
    private var timer: Timer?;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.brightness = UIScreen.main.brightness;
        queueScreenDimming();
    }

    /**
     * Creates a timer that will dim the screen after a bit
     */
    func queueScreenDimming() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {(timer) in
            UIScreen.main.brightness = 0.7;
        });
    }

    @IBAction func tapStart(_ sender: UITapGestureRecognizer) {
        // Once the screen has been tapped, stop the timer and bring up the brightness
        timer?.invalidate();
        UIScreen.main.brightness = brightness;
        self.performSegue(withIdentifier: "jobApplicationSegue", sender: self);
    }

    @IBAction func unwindFromApplication(segue: UIStoryboardSegue) {
        queueScreenDimming();
    }
}

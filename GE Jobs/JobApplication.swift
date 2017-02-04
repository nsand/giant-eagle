//
//  JobApplication.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 2/2/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import Foundation
import UIKit

class JobApplication: UIApplication {
    var timer: Timer?
    override init() {
        super.init()
    }
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        // Watch for touches; this will reset the timeout
        if let touches = event.allTouches {
            if touches.count > 0 {
                for touch in touches {
                    if touch.phase == .began {
                        // Reset countdown
                        resetTimer()
                    }
                }
            }
        }
    }
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: { (timer) in
            self.showAlert()
        })
    }

    func showAlert() {
        // Inactivity period reached, show an alert allowing the user to continue. If there's no response, reset
        let alert = UIAlertController(title: "Are you still there?", message: "It's been awhile without activity. Are you still there?", preferredStyle: .alert)
        let confirmationTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false, block: { (timer) in
            alert.dismiss(animated: true, completion: nil)
            self.keyWindow?.rootViewController?.dismiss(animated: true, completion: {})
        })
        let action = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            confirmationTimer.invalidate()
        })

        alert.addAction(action)
        self.keyWindow?.rootViewController?.presentedViewController?.present(alert, animated: true, completion: nil)
    }
}

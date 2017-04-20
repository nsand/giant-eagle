//
//  Email.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 1/18/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import Foundation

class Email {

    static var QUEUE = [Person]()
    static var QUEUE_TIMER: Timer?
    static let API = "https://api.postmarkapp.com/email/withTemplate"
    static var CONFIG : [String: String]? {
        return NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Email", ofType: "plist")!) as? [String: String]
    }

    static func queue(_ person: Person) {
        QUEUE.append(person)
        if QUEUE_TIMER == nil {
            QUEUE_TIMER = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: {(t) in
                while QUEUE.count > 0 {
                    let p = QUEUE.removeFirst()
                    Email().send(p.asDictionary(), done: { (data, response, err) in
                        if err != nil {
                            // Well, it failed to send again; hopefully, we can send it later
                            Email.queue(p)
                        }
                    })
                }
            })
        }
    }

    func send(_ data: [String : Any], done: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let config = Email.CONFIG {
            let url = URL(string: Email.API)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            let body : [String: Any] = [
                "TemplateId": Int(config["template_id"]!)!,
                "TemplateModel": data,
                "InlineCss": true,
                "From": config["from"]!,
                "To": config["to"]!,
                "Bcc": config["bcc"]!
            ]

            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(config["token"]!, forHTTPHeaderField: "X-Postmark-Server-Token")
            session.dataTask(with: request, completionHandler: done).resume()
        }
        else {
            print("The configuration wasn't loaded")
        }
    }
}

//
//  main.swift
//  GE Jobs
//
//  Created by Nick Sandonato on 2/2/17.
//  Copyright © 2017 Cranberry Giant Eagle. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), NSStringFromClass(JobApplication.self), NSStringFromClass(AppDelegate.self))

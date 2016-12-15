//
//  execCommand.swift
//  genicon
//
//  Created by Kaiyin Zhong on 12/14/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//



import Foundation

@discardableResult
public func execCommand(_ cwd: String, _ args: String...) -> Int32 {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.currentDirectoryPath = cwd
    process.arguments = args
    process.launch()
    process.waitUntilExit()
    return process.terminationStatus
}


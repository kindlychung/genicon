//
//  main.swift
//  genicon
//
//  Created by Kaiyin Zhong on 12/14/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Foundation

if CommandLine.arguments.contains("--help") || CommandLine.arguments.contains("-h") || CommandLine.arguments.dropFirst().isEmpty {
    print("\n genicon: A command line tool for generating icons for Cocoa apps.\n", "© Kaiyin Zhong 2016\n\n", "Usage: \n", "genicon INPUT OUTPUT_FOLDER")
    exit(0)
}

let fm = FileManager.default
let cwd = fm.currentDirectoryPath
extension String {
    var absolutePath: String {
        if self == "." {
            return cwd
        }
        if self.hasPrefix("/") {
            return self
        }
        return cwd + "/" + self
    }
    func fileURL(isDirectory: Bool) -> URL? {
        return URL(fileURLWithPath: absolutePath, isDirectory: isDirectory)
    }
}

// set up folders
let inputFile: URL    = CommandLine.arguments[1].fileURL(isDirectory: false)!
let outputFolder: URL = CommandLine.arguments[2].fileURL(isDirectory: true)!
//let inputFile = URL(string: "file:///Users/kaiyin/Desktop/dr89/Dr89.svg")!
//let outputFolder = URL(string: "file:///tmp")!
let iconFolder = outputFolder.appendingPathComponent("AppIcon.appiconset", isDirectory: true)




do {
    if !fm.fileExists(atPath: iconFolder.path) {
        try fm.createDirectory(at: iconFolder, withIntermediateDirectories: true, attributes: [:])
    } else {
        fputs("Icon folder already exists, creation skipped.\n", stderr)
    }
} catch {
    fputs("Failed to create icon folder.\n", stderr)
    fputs("Error: \(error)\n", stderr)
}

// generate Contents.json
var contents = Contents()
let size = [16, 32, 128, 512]
for sz in size {
    for sc in 1...2 {
        let img = ImageInfo(size: sz, scale: sc)
        contents.images.append(img)
    }
}
let jsonFilename = "Contents.json"
let jsonUrl = iconFolder.appendingPathComponent(jsonFilename)
do {
    if fm.fileExists(atPath: jsonUrl.path) {
        fputs("\(jsonFilename) already exists, creation skipped.\n", stderr)
    } else {
        try contents.json.write(to: jsonUrl, atomically: true, encoding: String.Encoding.utf8)
    }
} catch {
    fputs("Failed to write Contents.json file.", stderr)
    fputs("Error: \(error)\n", stderr)
}

// extract data for creating image files
var images = contents.images.sorted(by: {
    $0.realSize > $1.realSize
})
for (i, img) in images.enumerated() {
    images[i].filename = iconFolder.appendingPathComponent(img.filename).path
}

// image production function
func produceImage(sizeString: String, input: String, output: String) {
    execCommand(iconFolder.path, "/usr/local/bin/convert", "-background", "none", "-resize", sizeString, input, output)
}


// produce the largest image, 1024x1024
if fm.fileExists(atPath: images.first!.filename.absolutePath) {
    fputs("1024x1024 icon already exists, creation skipped.", stderr)
} else {
    produceImage(sizeString: images.first!.realSizeString, input: inputFile.path, output: images.first!.filename)
}
// produce smaller images
for img in images.dropFirst() {
    produceImage(sizeString: img.realSizeString, input: images.first!.filename, output: img.filename)
}


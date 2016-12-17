//
//  extension.swift
//  genicon
//
//  Created by Kaiyin Zhong on 12/17/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Foundation
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

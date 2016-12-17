//
//  generateJson.swift
//  genicon
//
//  Created by Kaiyin Zhong on 12/17/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Foundation

public func generateContents(sizes: [Int], scales: [Int], platform: Platform) -> Contents {
    var contents = Contents()
    for sz in sizes {
        for sc in scales {
            let img = ImageInfo(size: sz, scale: sc, platform: platform)
            contents.images.append(img)
        }
    }
    return contents
}

public let macSizes = [16, 32, 128, 512]
public let macScales = [1, 2]
public let iphoneSizes = [20, 29, 40, 60]
public let iphoneScales = [2, 3]

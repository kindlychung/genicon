//
//  dataModels.swift
//  genicon
//
//  Created by Kaiyin Zhong on 12/14/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Foundation

protocol Jsonifiable {
    var json: String { get }
}

public struct Contents: Jsonifiable {
    var images: [ImageInfo] = []
    var info: Info = Info()
    var json: String {
        var imagesJsonArray: [String] = []
        for img in images {
            imagesJsonArray.append(img.json)
        }
        let imagesJsonPair = ("images", concatJson(imagesJsonArray, delims: JsonBrackets() as JsonDelimPairs) as Any)
        let imagesJson = jsonify(pair: imagesJsonPair, quoteValue: false)
        let infoJson = jsonify(pair: ("info", info.json), quoteValue: false)
        return concatJson([imagesJson, infoJson], delims: JsonBraces() as JsonDelimPairs)
    }
}

public struct Info: Jsonifiable {
    let version = 1
    let author = "xcode"
    var json: String {
        let versionJson = jsonify(pair: ("version", version), quoteValue: false)
        let authorJson = jsonify(pair: ("author", author), quoteValue: true)
        return concatJson([versionJson, authorJson], delims: JsonBraces() as JsonDelimPairs)
        
    }
}

public enum Platform: String {
    case mac = "mac"
    case iphone = "iphone"
}

public struct ImageInfo: Jsonifiable {
    let size: String
    let scale: String
    private var idiom = ""
    var filename: String
    let realSize: Int
    let realSizeString: String
    public init(size sz: Int, scale sc: Int, platform: Platform) {
        realSize = sz * sc
        realSizeString = sizeString(realSize)
        size = sizeString(sz)
        scale = scaleString(sc)
        filename =  iconFilename(sizeString: realSizeString)
        idiom = platform.rawValue 
    }
    var json: String {
        let sizeJson = jsonify(pair: ("size", size), quoteValue: true)
        let scaleJson = jsonify(pair: ("scale", scale), quoteValue: true)
        let idiomJson = jsonify(pair: ("idiom", idiom), quoteValue: true)
        let filenameJson = jsonify(pair: ("filename", filename), quoteValue: true)
        return concatJson([
            sizeJson,
            scaleJson,
            idiomJson,
            filenameJson
            ], delims: JsonBraces() as JsonDelimPairs)
    }
}


fileprivate func escapeDoubleQuote(s: String) -> String {
    return s.replacingOccurrences(of: "\"", with: "\\\"")
}

fileprivate func quote<T>(_ obj: T) -> String where T: Any {
    switch obj {
    case let obj as String:
        return "\"\(escapeDoubleQuote(s: obj))\""
    default:
        return "\"\(obj)\""
    }
}

/// For opening and closing strings of a json string.
protocol JsonDelimPairs {
    var start: String {get}
    var end: String {get}
}


/// Brackets used as surrounding delimiters. Suitable for arrays.
public struct JsonBrackets: JsonDelimPairs {
    let start = "["
    let end = "]"
}

/// Braces used as surrounding delimiters. Suitable for dictionarys.
public struct JsonBraces: JsonDelimPairs {
    let start = "{"
    let end = "}"
}

public func iconFilename(sizeString s: String) -> String {
    return "icon_\(s).png"
}

public func sizeString(_ size: Int) -> String {
    return "\(size)x\(size)"
}

public func scaleString(_ scale: Int) -> String {
    return "\(scale)x"
}



/// Convert a tuple to a json string.
///
/// - Parameters:
///   - pair: A tuple to be converted. The first element of the tuple should always be a String, and considered a key in the json dictionary. The second element is considered the value.
///   - quoteValue: Whether the second element should be quoted.
/// - Returns: A json string.
public func jsonify(pair: (String, Any), quoteValue: Bool) -> String {
    var result = ""
    let (s, obj) = pair
    let key = quote(s)
    if quoteValue {
        result += "\(key): \(quote(obj))"
    } else {
        result += "\(key): \(obj)"
    }
    return result
}

func concatJson(_ strings: [String], delims: JsonDelimPairs) -> String {
    return "\(delims.start)\n" + strings.joined(separator: ",\n") + "\n\(delims.end)"
}




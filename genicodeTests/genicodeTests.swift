//
//  genicodeTests.swift
//  genicodeTests
//
//  Created by Kaiyin Zhong on 12/15/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import XCTest

@testable import "genicon"

class genicodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let img = ImageInfo(size: 15, scale: 2, outputTo: "/tmp")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonifyPair() {
        var s = jsonify(("size", 15), false)
        XCTAssert(s == "\"size\": 15\n")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

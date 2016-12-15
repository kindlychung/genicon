//
//  genicodeTests.swift
//  genicodeTests
//
//  Created by Kaiyin Zhong on 12/15/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import XCTest



class genicodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonifyPair() {
        var s = jsonify(pair: ("size", 15), quoteValue: false)
        XCTAssert(s == "\"size\": 15")
        s = jsonify(pair: ("length", 23.1), quoteValue: false)
        XCTAssert(s == "\"length\": 23.1")
        s = jsonify(pair: ("name", "Julia"), quoteValue: true)
        XCTAssert(s == "\"name\": \"Julia\"")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


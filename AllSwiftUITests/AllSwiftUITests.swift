//
//  AllSwiftUITests.swift
//  AllSwiftUITests
//
//  Created by Renjun Li on 2021/12/7.
//

import XCTest
@testable import AllSwiftUI

class AllSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    @Converter(initialValue: "100", from: "USD", to: "CNY", rate: 6.88)
    var usd_cny
    
    @Converter(initialValue: "100", from: "CNY", to: "EUR", rate: 0.13)
    var cny_eur

    func testPropertyWrapper() {
        print("\(usd_cny) = \($usd_cny)") // wrappedValue = projectedValue
        print("\(cny_eur) = \($cny_eur)")
    }
}

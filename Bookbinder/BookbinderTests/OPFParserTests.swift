//
//  OPFParserTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
@testable import Bookbinder

class OPFParserTests: QuickSpec {
    override func spec() {
        describe("OPFDocument") {
            it("works") {
                let opfPath = "OPFs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: opfPath, withExtension: "opf") else {
                    fail("Invalid opf path for test")
                    return
                }
                let opfDocument = OPFDocument(url: url)
                expect(opfDocument).notTo(beNil())
                let package = opfDocument?.package
                expect(package).notTo(beNil())
                expect(package?.uniqueIdentifier).to(equal("uid"))
            }
        }
    }
}

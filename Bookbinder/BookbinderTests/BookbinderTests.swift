//
//  BookbinderTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 4/14/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
@testable import Bookbinder

class BookbinderTests: QuickSpec {
    override func spec() {
        describe("Bookbinder") {
            it("works") {
                let zipPath = "ZIPs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: zipPath, withExtension: "epub") else {
                    fail("Invalid zip path for test")
                    return
                }
                let bookbinder = Bookbinder()
                let ebook = bookbinder.bindBook(at: url)
                expect(ebook).notTo(beNil())
                expect(ebook?.identifier).to(equal("Alice's_Adventures_in_Wonderland"))
                let expectedURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("Alice's_Adventures_in_Wonderland")
                expect(ebook?.baseURL).to(equal(expectedURL))
            }
        }
    }
}

//
//  ContainerParserTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
@testable import Bookbinder

class ContainerParserTests: QuickSpec {
    override func spec() {
        describe("ContainerDocument") {
            it("works") {
                let containerPath = "Containers/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: containerPath, withExtension: "xml") else {
                    fail("Invalid container path for test")
                    return
                }
                let containerDocument = ContainerDocument(url: url)
                expect(containerDocument).notTo(beNil())
                expect(containerDocument?.opfPath).to(equal("epub/content.opf"))
            }
        }
    }
}

//
//  NCXParserTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
@testable import Bookbinder

class NCXParserTests: QuickSpec {
    override func spec() {
        describe("NCXDocument") {
            it("works") {
                let ncxPath = "NCXs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: ncxPath, withExtension: "ncx") else {
                    fail("Invalid ncx path for test")
                    return
                }
                let ncxDocument = NCXDocument(url: url)
                expect(ncxDocument).notTo(beNil())
                expect(ncxDocument?.title).to(equal("Table of Contents"))
                let points = ncxDocument?.points
                expect(points?.count).to(equal(17))
                let expectedLabels = ["Title Page",
                                      "Imprint",
                                      "All in the Golden Afternoon",
                                      "I: Down the Rabbit-Hole",
                                      "II: The Pool of Tears",
                                      "III: A Caucus-Race and a Long Tale",
                                      "IV: The Rabbit Sends in a Little Bill",
                                      "V: Advice From a Caterpillar",
                                      "VI: Pig and Pepper",
                                      "VII: A Mad Tea-Party",
                                      "VIII: The Queen’s Croquet-Ground",
                                      "IX: The Mock Turtle’s Story",
                                      "X: The Lobster Quadrille",
                                      "XI: Who Stole the Tarts?",
                                      "XII: Alice’s Evidence",
                                      "Colophon",
                                      "Uncopyright"]
                let expectedSrcs = ["text/titlepage.xhtml",
                                    "text/imprint.xhtml",
                                    "text/epigraph.xhtml",
                                    "text/chapter-1.xhtml",
                                    "text/chapter-2.xhtml",
                                    "text/chapter-3.xhtml",
                                    "text/chapter-4.xhtml",
                                    "text/chapter-5.xhtml",
                                    "text/chapter-6.xhtml",
                                    "text/chapter-7.xhtml",
                                    "text/chapter-8.xhtml",
                                    "text/chapter-9.xhtml",
                                    "text/chapter-10.xhtml",
                                    "text/chapter-11.xhtml",
                                    "text/chapter-12.xhtml",
                                    "text/colophon.xhtml",
                                    "text/uncopyright.xhtml"]
                for (i, point) in points?.enumerated() ?? [].enumerated() {
                    expect(point.order).to(equal(i + 1))
                    expect(point.label).to(equal(expectedLabels[i]))
                    expect(point.src).to(equal(expectedSrcs[i]))
                }
            }
        }
    }
}

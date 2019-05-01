//
//  EPUBBookTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
@testable import Bookbinder

class EPUBBookTests: QuickSpec {
    override func spec() {
        describe("EPUBBook") {
            it("works") {
                let epubPath = "EPUBs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: epubPath, withExtension: nil) else {
                    fail("Invalid epub path for test")
                    return
                }
                let ebook = EPUBBook(identifier: "Alice's_Adventures_in_Wonderland", contentsOf: url)
                expect(ebook).notTo(beNil())
                expect(ebook?.identifier).to(equal("Alice's_Adventures_in_Wonderland"))
                expect(ebook?.baseURL).to(equal(url))
                expect(ebook?.resourceBaseURL).to(equal(url.appendingPathComponent("epub")))
                expect(ebook?.opf).notTo(beNil())
                expect(ebook?.uniqueID).to(equal("url:https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland"))
                expect(ebook?.releaseID).to(equal("\(ebook?.uniqueID ?? "")@2017-03-09T17:21:15Z"))
                expect(ebook?.publicationDate).to(equal(ISO8601DateFormatter().date(from: "2015-05-12T00:01:00Z")))
                expect(ebook?.coverImageURL).to(equal(ebook?.resourceBaseURL.appendingPathComponent("images/cover.jpg")))
                expect(ebook?.tocURL).to(equal(ebook?.resourceBaseURL.appendingPathComponent("toc.xhtml")))
                expect(ebook?.ncx).notTo(beNil())
                let pages = ebook?.pages
                expect(pages?.count).to(equal(18))
                let expectedPagePaths = ["text/titlepage.xhtml",
                                         "text/imprint.xhtml",
                                         "text/epigraph.xhtml",
                                         "text/halftitle.xhtml",
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
                for (i, page) in pages?.enumerated() ?? [].enumerated() {
                    expect(page).to(equal(ebook?.resourceBaseURL.appendingPathComponent(expectedPagePaths[i])))
                }
            }
        }
    }
}

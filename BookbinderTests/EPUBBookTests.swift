//
//  EPUBBookTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
import Bookbinder

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
                expect(ebook?.container).notTo(beNil())
                expect(ebook?.opf).notTo(beNil())
                expect(ebook?.uniqueID).to(equal("url:https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland"))
                expect(ebook?.releaseID).to(equal("\(ebook?.uniqueID ?? "")@2017-03-09T17:21:15Z"))
                expect(ebook?.publicationDate).to(equal(ISO8601DateFormatter().date(from: "2015-05-12T00:01:00Z")))
                let coverImageURL = ebook?.resourceBaseURL.appendingPathComponent("images/cover.jpg")
                expect(ebook?.coverImageURLs).to(equal([coverImageURL, coverImageURL]))
                expect(ebook?.tocURL).to(equal(ebook?.resourceBaseURL.appendingPathComponent("toc.xhtml")))
                expect(ebook?.ncx).notTo(beNil())
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
                expect(ebook?.pages).to(equal(expectedPagePaths.map { ebook?.resourceBaseURL.appendingPathComponent($0) }))
            }
        }

        describe("CustomBook") {
            it("works") {
                let epubPath = "EPUBs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: epubPath, withExtension: nil) else {
                    fail("Invalid epub path for test")
                    return
                }
                let ebook = CustomBook(identifier: "Alice's_Adventures_in_Wonderland", contentsOf: url)
                expect(ebook).notTo(beNil())
                let creators = ebook?.firstAuthors
                expect(creators?.count).to(equal(1))
                expect(creators?[0]).to(equal("Lewis Carroll"))
                let contributors = ebook?.secondAuthors
                expect(contributors?.count).to(equal(5))
                expect(contributors?[0]).to(equal("The League of Moveable Type"))
                expect(contributors?[1]).to(equal("Ivan Ivanovich Shishkin"))
                expect(contributors?[2]).to(equal("Arthur DiBianca"))
                expect(contributors?[3]).to(equal("David Widger"))
                expect(contributors?[4]).to(equal("Alex Cabal"))
                let guidRefs = ebook?.guideRefs
                expect(guidRefs?.count).to(equal(6))
                expect(guidRefs?[0].title).to(equal("Title Page"))
                expect(guidRefs?[0].href).to(equal("text/titlepage.xhtml"))
                expect(guidRefs?[0].type).to(equal("title-page text"))
                expect(guidRefs?[1].title).to(equal("Imprint"))
                expect(guidRefs?[1].href).to(equal("text/imprint.xhtml"))
                expect(guidRefs?[1].type).to(equal("imprint"))
                expect(guidRefs?[2].title).to(equal("All in the Golden Afternoon"))
                expect(guidRefs?[2].href).to(equal("text/epigraph.xhtml"))
                expect(guidRefs?[2].type).to(equal("z3998:fiction epigraph"))
                expect(guidRefs?[3].title).to(equal("Alice’s Adventures in Wonderland"))
                expect(guidRefs?[3].href).to(equal("text/chapter-1.xhtml"))
                expect(guidRefs?[3].type).to(equal("bodymatter"))
                expect(guidRefs?[4].title).to(equal("Colophon"))
                expect(guidRefs?[4].href).to(equal("text/colophon.xhtml"))
                expect(guidRefs?[4].type).to(equal("colophon"))
                expect(guidRefs?[5].title).to(equal("Uncopyright"))
                expect(guidRefs?[5].href).to(equal("text/uncopyright.xhtml"))
                expect(guidRefs?[5].type).to(equal("copyright page"))
            }
        }
    }
}

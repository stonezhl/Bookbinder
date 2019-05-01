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
                // metadata
                let metadata = package?.metadata
                expect(metadata).notTo(beNil())
                let identifiers = metadata?.identifiers
                expect(identifiers?.count).to(equal(1))
                expect(identifiers?[0].id).to(equal("uid"))
                expect(identifiers?[0].text).to(equal("url:https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland"))
                let titles = metadata?.titles
                expect(titles?.count).to(equal(1))
                expect(titles?[0]).to(equal("Alice's Adventures in Wonderland"))
                let contributors = metadata?.contributors
                expect(contributors?.count).to(equal(5))
                expect(contributors?[0]).to(equal("The League of Moveable Type"))
                expect(contributors?[1]).to(equal("Ivan Ivanovich Shishkin"))
                expect(contributors?[2]).to(equal("Arthur DiBianca"))
                expect(contributors?[3]).to(equal("David Widger"))
                expect(contributors?[4]).to(equal("Alex Cabal"))
                let creators = metadata?.creators
                expect(creators?.count).to(equal(1))
                expect(creators?[0]).to(equal("Lewis Carroll"))
                let date = metadata?.date
                expect(date).to(equal("2015-05-12T00:01:00Z"))
                let description = metadata?.description
                expect(description).to(equal("A young girl follows a white rabbit into a strange land of poetry, humor, and whimsy."))
                let publisher = metadata?.publisher
                expect(publisher).to(equal("Standard Ebooks"))
                let rights = metadata?.rights
                expect(rights).to(equal("The source text and artwork in this ebook edition are believed to be in the U.S. public domain. This ebook edition is released under the terms in the CC0 1.0 Universal Public Domain Dedication, available at https://creativecommons.org/publicdomain/zero/1.0/. For full license information see the Uncopyright file included at the end of this ebook."))
                let sources = metadata?.sources
                expect(sources?.count).to(equal(2))
                expect(sources?[0]).to(equal("https://www.gutenberg.org/ebooks/11"))
                expect(sources?[1]).to(equal("https://archive.org/stream/adventuresalices00carrrich"))
                let subjects = metadata?.subjects
                expect(subjects?.count).to(equal(1))
                expect(subjects?[0]).to(equal("Fantasy"))
                let modifiedDate = metadata?.modifiedDate
                expect(modifiedDate).to(equal("2017-03-09T17:21:15Z"))
                let coverImageID = metadata?.coverImageID
                expect(coverImageID).to(equal("cover.jpg"))
                // manifest
                let manifest = package?.manifest
                expect(manifest).notTo(beNil())
                let items = manifest?.items
                expect(items?.count).to(equal(25))
                var id = "ncx"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("toc.ncx"))
                expect(items?[id]?.mediaType).to(equal("application/x-dtbncx+xml"))
                expect(items?[id]?.properties).to(beNil())
                id = "toc.xhtml"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("toc.xhtml"))
                expect(items?[id]?.mediaType).to(equal("application/xhtml+xml"))
                expect(items?[id]?.properties).to(equal("nav"))
                id = "core.css"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("css/core.css"))
                expect(items?[id]?.mediaType).to(equal("text/css"))
                expect(items?[id]?.properties).to(beNil())
                id = "local.css"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("css/local.css"))
                expect(items?[id]?.mediaType).to(equal("text/css"))
                expect(items?[id]?.properties).to(beNil())
                id = "cover.jpg"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("images/cover.jpg"))
                expect(items?[id]?.mediaType).to(equal("image/jpeg"))
                expect(items?[id]?.properties).to(equal("cover-image"))
                id = "logo.png"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("images/logo.png"))
                expect(items?[id]?.mediaType).to(equal("image/png"))
                expect(items?[id]?.properties).to(beNil())
                id = "titlepage.png"
                expect(items?[id]?.id).to(equal(id))
                expect(items?[id]?.href).to(equal("images/titlepage.png"))
                expect(items?[id]?.mediaType).to(equal("image/png"))
                expect(items?[id]?.properties).to(beNil())
                for i in 1...12 {
                    id = "chapter-\(i).xhtml"
                    expect(items?[id]?.id).to(equal(id))
                    expect(items?[id]?.href).to(equal("text/chapter-\(i).xhtml"))
                    expect(items?[id]?.mediaType).to(equal("application/xhtml+xml"))
                    expect(items?[id]?.properties).to(beNil())
                }
                for file in ["colophon.xhtml",
                             "epigraph.xhtml",
                             "halftitle.xhtml",
                             "imprint.xhtml",
                             "uncopyright.xhtml",
                             "titlepage.xhtml"] {
                                expect(items?[file]?.id).to(equal(file))
                                expect(items?[file]?.href).to(equal("text/\(file)"))
                                expect(items?[file]?.mediaType).to(equal("application/xhtml+xml"))
                                expect(items?[file]?.properties).to(beNil())
                }
                // spine
                let spine = package?.spine
                expect(spine).notTo(beNil())
                let toc = spine?.toc
                expect(toc).to(equal("ncx"))
                let itemrefs = spine?.itemrefs
                expect(itemrefs?.count).to(equal(18))
                let expectedIdrefs = ["titlepage.xhtml",
                                      "imprint.xhtml",
                                      "epigraph.xhtml",
                                      "halftitle.xhtml",
                                      "chapter-1.xhtml",
                                      "chapter-2.xhtml",
                                      "chapter-3.xhtml",
                                      "chapter-4.xhtml",
                                      "chapter-5.xhtml",
                                      "chapter-6.xhtml",
                                      "chapter-7.xhtml",
                                      "chapter-8.xhtml",
                                      "chapter-9.xhtml",
                                      "chapter-10.xhtml",
                                      "chapter-11.xhtml",
                                      "chapter-12.xhtml",
                                      "colophon.xhtml",
                                      "uncopyright.xhtml"]
                for (i, itemref) in itemrefs!.enumerated() {
                    expect(itemref.idref).to(equal(expectedIdrefs[i]))
                }
            }
        }
    }
}

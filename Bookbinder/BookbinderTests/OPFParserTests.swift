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
                expect(package?.manifest).notTo(beNil())
                // spine
                expect(package?.spine).notTo(beNil())
            }
        }
    }
}

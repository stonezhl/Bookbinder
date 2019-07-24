//
//  BookbinderTests.swift
//  BookbinderTests
//
//  Created by Stone Zhang on 4/14/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Quick
import Nimble
import Bookbinder
import Kanna

struct GuideRef {
    let title: String
    let href: String
    let type: String

    init(_ reference: XMLElement) {
        title = reference["title"] ?? ""
        href = reference["href"] ?? ""
        type = reference["type"] ?? ""
    }
}

class CustomBook: EPUBBook {
    lazy var firstAuthors: [String]? = {
        return opf.package?.metadata?.creators
    }()

    lazy var secondAuthors: [String]? = {
        return opf.package?.metadata?.contributors
    }()

    // http://www.idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6
    lazy var guideRefs: [GuideRef] = {
        var refs = [GuideRef]()
        let references = opf.document.xpath("/opf:package/opf:guide/opf:reference", namespaces: XPath.opf.namespace)
        for reference in references {
            refs.append(GuideRef(reference))
        }
        return refs
    }()
}

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
                let tmpDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                expect(bookbinder.configuration.rootURL).to(equal(tmpDirURL))
                let ebook = bookbinder.bindBook(at: url)
                expect(ebook).notTo(beNil())
                expect(ebook?.identifier).to(equal("Alice's_Adventures_in_Wonderland"))
                let expectedURL = tmpDirURL.appendingPathComponent("Alice's_Adventures_in_Wonderland")
                expect(ebook?.baseURL).to(equal(expectedURL))
            }
        }

        describe("CustomBook") {
            it("works") {
                let zipPath = "ZIPs/Alice's_Adventures_in_Wonderland"
                guard let url = Bundle(for: type(of: self)).url(forResource: zipPath, withExtension: "epub") else {
                    fail("Invalid zip path for test")
                    return
                }
                let bookbinder = Bookbinder()
                let ebook = bookbinder.bindBook(at: url, to: CustomBook.self)
                expect(ebook).notTo(beNil())
                expect(ebook?.firstAuthors?.count).to(equal(1))
                expect(ebook?.secondAuthors?.count).to(equal(5))
                expect(ebook?.guideRefs.count).to(equal(6))
            }
        }
    }
}

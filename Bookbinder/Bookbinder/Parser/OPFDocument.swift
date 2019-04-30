//
//  OPFDocument.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

enum XPath {
    case xmlns
    case dc

    var namespace: [String: String] {
        switch self {
        case .xmlns:
            return ["xmlns": "http://www.idpf.org/2007/opf"]
        case .dc:
            return ["dc": "http://purl.org/dc/elements/1.1/"]
        }
    }
}

struct OPFDocument {
    let package: OPFPackage?

    private let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            package = OPFPackage(document: document)
        } catch {
            return nil
        }
    }
}

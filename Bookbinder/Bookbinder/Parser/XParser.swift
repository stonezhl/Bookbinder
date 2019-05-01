//
//  XParser.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Foundation

enum XPath {
    case opf
    case dc
    case ncx

    var namespace: [String: String] {
        switch self {
        case .opf:
            return ["opf": "http://www.idpf.org/2007/opf"]
        case .dc:
            return ["dc": "http://purl.org/dc/elements/1.1/"]
        case .ncx:
            return ["ncx": "http://www.daisy.org/z3986/2005/ncx/"]
        }
    }
}

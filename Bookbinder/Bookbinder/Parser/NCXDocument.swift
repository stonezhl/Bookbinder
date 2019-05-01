//
//  NCXDocument.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct NCXDocument {
    let ncx: NCXNode?

    private let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            ncx = NCXNode(document: document)
        } catch {
            return nil
        }
    }
}

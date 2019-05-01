//
//  ContainerDocument.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct ContainerDocument {
    let opfPath: String?

    private let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            opfPath = document.at_xpath("//container:rootfile[@full-path]/@full-path", namespaces: XPath.container.namespace)?.text
        } catch {
            return nil
        }
    }
}

//
//  OPFSpine.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-spine-elem
struct OPFSpine {
    let toc: String?
    private(set) var itemrefs = [SpineItemref]()
    // page-progression-direction [optional]
    // toc [optional] [OBSOLETE]

    init?(package: XMLElement) {
        guard let spine = package.at_xpath("xmlns:spine", namespaces: XPath.xmlns.namespace) else { return nil }
        toc = spine["toc"]
        let itemrefElements = spine.xpath("xmlns:itemref", namespaces: XPath.xmlns.namespace)
        for itemrefElement in itemrefElements {
            guard let itemref = SpineItemref(itemrefElement) else { continue }
            itemrefs.append(itemref)
        }
    }
}

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-itemref-elem
struct SpineItemref {
    let idref: String
    let linear: String?
    // properties [optional]

    init?(_ itemref: XMLElement) {
        guard let itemIdref = itemref["idref"] else { return nil }
        idref = itemIdref
        linear = itemref["linear"]
    }
}

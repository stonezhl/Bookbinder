//
//  OPFSpine.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-spine-elem
public struct OPFSpine {
    public let toc: String?
    public private(set) var itemrefs = [SpineItemref]()
    // page-progression-direction [optional]
    // toc [optional] [OBSOLETE]

    init?(package: XMLElement) {
        guard let spine = package.at_xpath("opf:spine", namespaces: XPath.opf.namespace) else { return nil }
        toc = spine["toc"]
        let itemrefElements = spine.xpath("opf:itemref", namespaces: XPath.opf.namespace)
        for itemrefElement in itemrefElements {
            guard let itemref = SpineItemref(itemrefElement) else { continue }
            itemrefs.append(itemref)
        }
    }
}

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-itemref-elem
public struct SpineItemref {
    public let idref: String
    public let linear: String?
    // properties [optional]

    public var isPrimary: Bool {
        guard let linear = self.linear else {
            return true
        }
        return linear == "yes"
    }

    init?(_ itemref: XMLElement) {
        guard let itemIdref = itemref["idref"] else { return nil }
        idref = itemIdref
        linear = itemref["linear"]
    }
}

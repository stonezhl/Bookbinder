//
//  OPFManifest.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct OPFManifest {
    init?(package: XMLElement) {
        guard let manifest = package.at_xpath("xmlns:manifest", namespaces: XPath.xmlns.namespace) else { return nil }
    }
}

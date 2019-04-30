//
//  OPFMetadata.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct OPFMetadata {
    init?(package: XMLElement) {
        guard let metadata = package.at_xpath("xmlns:metadata", namespaces: XPath.xmlns.namespace) else { return nil }
    }
}

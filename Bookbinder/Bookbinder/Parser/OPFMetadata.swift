//
//  OPFMetadata.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct OPFMetadata {
    init?(package: XMLElement, namespaces: [String: String]) {
        guard let metadata = package.at_xpath(XPath.xmlns("metadata").expression, namespaces: namespaces) else { return nil }
    }
}

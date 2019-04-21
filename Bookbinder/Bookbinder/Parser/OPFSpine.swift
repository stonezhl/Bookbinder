//
//  OPFSpine.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

struct OPFSpine {
    init?(package: XMLElement, namespaces: [String: String]) {
        guard let spine = package.at_xpath(XPath.xmlns("spine").expression, namespaces: namespaces) else { return nil }
    }
}

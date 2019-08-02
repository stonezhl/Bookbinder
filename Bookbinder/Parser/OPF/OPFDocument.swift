//
//  OPFDocument.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/
public struct OPFDocument {
    public let package: OPFPackage?

    public let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            package = OPFPackage(document: document)
        } catch {
            print("Parsing the XML file at \(url) failed with error: \(error)")
            return nil
        }
    }
}

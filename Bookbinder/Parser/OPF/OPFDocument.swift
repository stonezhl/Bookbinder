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
    // https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-package-def
    public let uniqueIdentifierID: String
    public let metadata: OPFMetadata
    public let manifest: OPFManifest
    public let spine: OPFSpine
    // http://www.idpf.org/epub/301/spec/epub-publications.html#sec-guide-elem
    // let guide

    public let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            guard let package = document.at_xpath("/opf:package", namespaces: XPath.opf.namespace) else { return nil }
            guard let uid = package["unique-identifier"] else { return nil }
            guard let metadata = OPFMetadata(package: package) else { return nil }
            guard let manifest = OPFManifest(package: package) else { return nil }
            guard let spine = OPFSpine(package: package) else { return nil }
            uniqueIdentifierID = uid
            self.metadata = metadata
            self.manifest = manifest
            self.spine = spine
        } catch {
            print("Parsing the XML file at \(url) failed with error: \(error)")
            return nil
        }
    }
}

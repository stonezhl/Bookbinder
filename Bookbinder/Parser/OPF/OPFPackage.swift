//
//  OPFPackage.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-package-def
public struct OPFPackage {
    public let uniqueIdentifierID: String?
    public let metadata: OPFMetadata?
    public let manifest: OPFManifest?
    public let spine: OPFSpine?
    // http://www.idpf.org/epub/301/spec/epub-publications.html#sec-guide-elem
    // let guide

    init?(document: XMLDocument) {
        guard let package = document.at_xpath("/opf:package", namespaces: XPath.opf.namespace) else { return nil }
        uniqueIdentifierID = package["unique-identifier"]
        metadata =  OPFMetadata(package: package)
        manifest = OPFManifest(package: package)
        spine = OPFSpine(package: package)
    }
}

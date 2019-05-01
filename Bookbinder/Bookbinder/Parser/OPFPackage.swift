//
//  OPFPackage.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/
struct OPFPackage {
    let uniqueIdentifier: String?
    let metadata: OPFMetadata?
    let manifest: OPFManifest?
    let spine: OPFSpine?
    // http://www.idpf.org/epub/301/spec/epub-publications.html#sec-guide-elem
    // let guide

    init?(document: XMLDocument) {
        guard let package = document.at_xpath("/xmlns:package", namespaces: XPath.xmlns.namespace) else { return nil }
        uniqueIdentifier = package["unique-identifier"]
        metadata =  OPFMetadata(package: package)
        manifest = OPFManifest(package: package)
        spine = OPFSpine(package: package)
    }
}

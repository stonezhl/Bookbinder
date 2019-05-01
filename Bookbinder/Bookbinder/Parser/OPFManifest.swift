//
//  OPFManifest.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-manifest-elem
struct OPFManifest {
    private(set) var items = [String: ManifestItem]()

    init?(package: XMLElement) {
        guard let manifest = package.at_xpath("xmlns:manifest", namespaces: XPath.xmlns.namespace) else { return nil }
        let itemElements = manifest.xpath("xmlns:item", namespaces: XPath.xmlns.namespace)
        for itemElement in itemElements {
            guard let item = ManifestItem(itemElement) else { continue }
            items[item.id] = item
        }
    }
}

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#elemdef-package-item
struct ManifestItem {
    let id: String
    let href: String
    // https://idpf.github.io/epub-cmt/v3/
    let mediaType: String
    // https://idpf.github.io/epub-vocabs/package/item/#sec-item-property-values
    let properties: String?
    // duration [conditionally required]
    // fallback [conditionally required]
    // media-overlay [optional]

    init?(_ item: XMLElement) {
        guard let itemId = item["id"] else { return nil }
        guard let itemHref = item["href"] else { return nil }
        guard let itemMediaType = item["media-type"] else { return nil }
        id = itemId
        href = itemHref
        mediaType = itemMediaType
        properties = item["properties"]
    }
}

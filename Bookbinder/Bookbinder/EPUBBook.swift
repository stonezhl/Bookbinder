//
//  EPUBBook.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Foundation

class EPUBBook {
    let identifier: String
    let baseURL: URL
    let resourceBaseURL: URL
    let opf: OPFDocument

    // accessor

    // https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-metadata-elem-identifiers-uid
    lazy var uniqueID: String? = {
        guard let identifiers = opf.package?.metadata?.identifiers, let uniqueIdentifierID = opf.package?.uniqueIdentifierID else { return nil }
        for identifier in identifiers where identifier.id == uniqueIdentifierID {
            return identifier.text
        }
        return nil
    }()

    // https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-metadata-elem-identifiers-pid
    lazy var releaseID: String? = {
        guard let id = uniqueID else { return nil }
        guard let date = opf.package?.metadata?.modifiedDate else {
            return id
        }
        return id + "@" + date
    }()

    lazy var publicationDate: Date? = {
        guard let date = opf.package?.metadata?.date else { return nil }
        return ISO8601DateFormatter().date(from: date)
    }()

    // http://idpf.org/forum/topic-715
    lazy var coverImageURL: URL? = {
        guard let manifest = opf.package?.manifest else { return nil }
        for item in manifest.items.values where item.properties == "cover-image" {
            let url = resourceBaseURL.appendingPathComponent(item.href)
            if UIImage(contentsOfFile: url.path) != nil {
                return url
            }
        }
        guard let imageID = opf.package?.metadata?.coverImageID, let path = manifest.items[imageID]?.href else { return nil }
        let url = resourceBaseURL.appendingPathComponent(path)
        if UIImage(contentsOfFile: url.path) != nil {
            return url
        }
        return nil
    }()

    lazy var tocURL: URL? = {
        guard let manifest = opf.package?.manifest else { return nil }
        for item in manifest.items.values where item.properties == "nav" {
            return resourceBaseURL.appendingPathComponent(item.href)
        }
        return nil
    }()

    lazy var ncx: NCXDocument? = {
        guard let ncxID = opf.package?.spine?.toc, let path = opf.package?.manifest?.items[ncxID]?.href else { return nil }
        let url = resourceBaseURL.appendingPathComponent(path)
        return NCXDocument(url: url)
    }()

    lazy var pages: [URL]? = {
        return opf.package?.spine?.itemrefs
            .filter { $0.isPrimary }
            .compactMap {
                guard let path = opf.package?.manifest?.items[$0.idref]?.href else { return nil }
                return resourceBaseURL.appendingPathComponent(path)
        }
    }()

    init?(identifier: String? = nil, contentsOf baseURL: URL) {
        self.identifier = identifier ?? UUID().uuidString
        self.baseURL = baseURL
        // parse container file
        let containerURL = baseURL.appendingPathComponent("META-INF/container.xml")
        let container = ContainerDocument(url: containerURL)
        guard let opfPath = container?.opfPath else { return nil }
        // parse opf fitle
        let opfURL = baseURL.appendingPathComponent(opfPath)
        resourceBaseURL = opfURL.deletingLastPathComponent()
        guard let opf = OPFDocument(url: opfURL) else { return nil }
        self.opf = opf
    }
}

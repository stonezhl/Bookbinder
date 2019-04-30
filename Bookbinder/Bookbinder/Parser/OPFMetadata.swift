//
//  OPFMetadata.swift
//  Bookbinder
//
//  Created by Stone Zhang on 4/21/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-metadata-elem
struct OPFMetadata {
    // DCMES Required Elements
    private(set) var identifiers = [DCIdentifier]()
    private(set) var titles = [String]()
    private(set) var languages = [String]()
    // DCMES Optional Elements
    private(set) var contributors = [String]()
    // let coverage
    private(set) var creators = [String]()
    private(set) var date: String?
    private(set) var description: String?
    // let format
    private(set) var publisher: String?
    // let relation
    private(set) var rights: String?
    private(set) var sources = [String]()
    private(set) var subjects = [String]()
    // let type

    init?(package: XMLElement) {
        guard let metadata = package.at_xpath("xmlns:metadata", namespaces: XPath.xmlns.namespace) else { return nil }
        // DCMES
        let dcmes = metadata.xpath("dc:*", namespaces: XPath.dc.namespace)
        for dc in dcmes {
            guard let text = dc.text else { continue }
            switch dc.tagName {
            case "identifier":
                identifiers.append(DCIdentifier(dc))
            case "title":
                titles.append(text)
            case "language":
                languages.append(text)
            case "contributor":
                contributors.append(text)
            case "coverage":
                break
            case "creator":
                creators.append(text)
            case "date":
                date = text
            case "description":
                description = text
            case "format":
                break
            case "publisher":
                publisher = text
            case "relation":
                break
            case "rights":
                rights = text
            case "source":
                sources.append(text)
            case "subject":
                subjects.append(text)
            case "type":
                break
            default:
                break
            }
        }
    }
}

// Dublin Core Metadata Element Set, Version 1.1: Reference Description
// http://dublincore.org/documents/dces/
// http://dublincore.org/2012/06/14/dcelements
// opf:alt-rep [optional] – only allowed on contributor, creator, and publisher.
// opf:alt-rep-lang [conditionally required] – only allowed on contributor, creator, and publisher.
// dir [optional] – only allowed on contributor, coverage, creator, description, publisher, relation, rights and subject.
// opf:file-as [optional] – only allowed on contributor, creator, and publisher.
// id [optional] – allowed on any element.
// opf:role [optional] – only allowed on contributor and creator.
// opf:scheme [optional] – only allowed on identifier and source.
// xml:lang [optional] – only allowed on contributor, coverage, creator, description, publisher, relation, rights and subject.

// MARK: - DCMES Required Elements
// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dcmes-required

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dcidentifier
// dc:identifier
// text
// attributes:
// - id [optional]
// - opf:scheme [optional]
struct DCIdentifier {
    let text: String
    let id: String?

    init(_ dc: XMLElement) {
        text = dc.text ?? ""
        id = dc["id"]
    }
}

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dctitle
// dc:title
// text
// attributes:
// - opf:alt-rep [optional]
// - opf:alt-rep-lang [conditionally required]
// - dir [optional]
// - opf:file-as [optional]
// - id [optional]
// - xml:lang [optional]

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dclanguage
// dc:language
// text
// attributes:
// - id [optional]

// MARK: - DCMES Optional Elements
// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dcmes-optional-def

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dccontributor
// dc:contributor
// text
// attributes:
// - opf:alt-rep [optional]
// - opf:alt-rep-lang [conditionally required]
// - dir [optional]
// - opf:file-as [optional]
// - id [optional]
// - opf:role [optional]
// - xml:lang [optional]

// dc:coverage
// text
// attributes:
// - dir [optional]
// - id [optional]
// - xml:lang [optional]

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dccreator
// dc:creator {
// text
// attributes:
// - opf:alt-rep [optional]
// - opf:alt-rep-lang [conditionally required]
// - dir [optional]
// - opf:file-as [optional]
// - id [optional]
// - opf:role [optional]
// - xml:lang [optional]

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dcdate
// dc:date
// text

// dc:description
// text
// attributes:
// - dir [optional]
// - id [optional]
// - xml:lang [optional]

// dc:format

// dc:publisher
// text
// attributes:
// - opf:alt-rep [optional]
// - opf:alt-rep-lang [conditionally required]
// - dir [optional]
// - opf:file-as [optional]
// - id [optional]
// - xml:lang [optional]

// dc:relation
// text
// attributes:
// - dir [optional]
// - id [optional]
// - xml:lang [optional]

// dc:rights
// text
// attributes:
// - dir [optional]
// - id [optional]
// - xml:lang [optional]

// dc:source
// text: String
// attributes:
// - id [optional]
// - opf:scheme [optional]

// https://www.w3.org/Submission/2017/SUBM-epub-packages-20170125/#sec-opf-dcsubject
// dc:subject
// text
// attributes:
// - dir [optional]
// - id [optional]
// - xml:lang [optional]
// - opf:authority [optional]
// - opf:term [conditionally required]

// http://idpf.github.io/epub-registries/types/#sec-types
// dc:type
// text

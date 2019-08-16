//
//  NCXDocument.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Kanna

// http://www.idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.4.1
public struct NCXDocument {
    public let title: String?
    public private(set) var points = [NavPoint]()

    public let document: XMLDocument

    init?(url: URL) {
        do {
            document = try Kanna.XML(url: url, encoding: .utf8)
            guard let ncx = document.at_xpath("/ncx:ncx", namespaces: XPath.ncx.namespace) else { return nil }
            title = ncx.at_xpath("ncx:docTitle/ncx:text", namespaces: XPath.ncx.namespace)?.text
            let navPoints = ncx.xpath("ncx:navMap/ncx:navPoint", namespaces: XPath.ncx.namespace)
            for navPoint in navPoints {
                guard let point = NavPoint(navPoint) else { continue }
                points.append(point)
            }
        } catch {
            return nil
        }
    }
}

public struct NavPoint {
    public let order: Int
    public let label: String
    public let src: String
    public private(set) var subPoints = [NavPoint]()

    init?(_ navPoint: XMLElement) {
        guard let playOrder = navPoint["playOrder"], let pointOrder = Int(playOrder) else { return nil }
        guard let pointLabel = navPoint.at_xpath("ncx:navLabel/ncx:text", namespaces: XPath.ncx.namespace)?.text else { return nil }
        guard let pointSrc = navPoint.at_xpath("ncx:content/@src", namespaces: XPath.ncx.namespace)?.text else { return nil }
        order = pointOrder
        label = pointLabel
        src = pointSrc
        let subNavPoints = navPoint.xpath("ncx:navPoint", namespaces: XPath.ncx.namespace)
        for subNavPoint in subNavPoints {
            guard let point = NavPoint(subNavPoint) else { continue }
            subPoints.append(point)
        }
    }
}

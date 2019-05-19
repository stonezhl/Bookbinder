//
//  BookbinderConfiguration.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Foundation

public struct BookbinderConfiguration {
    public let rootURL: URL

    public init(rootURL: URL? = nil) {
        self.rootURL = rootURL ?? URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
}

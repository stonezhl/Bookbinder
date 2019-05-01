//
//  BookbinderConfiguration.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Foundation

struct BookbinderConfiguration {
    let rootURL: URL

    init(rootURL: URL? = nil) {
        self.rootURL = rootURL ?? URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
}

//
//  Bookbinder.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import Foundation
import ZIPFoundation

public class Bookbinder {
    public let configuration: BookbinderConfiguration

    public init(configuration: BookbinderConfiguration? = nil) {
        self.configuration = configuration ?? BookbinderConfiguration()
    }

    public func bindBook(at sourceURL: URL, identifier: String? = nil) -> EPUBBook? {
        let identifier = identifier ?? sourceURL.deletingPathExtension().lastPathComponent
        let baseURL = configuration.rootURL.appendingPathComponent(identifier)
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: baseURL.path) == false {
            do {
                // unzip ePub file
                try fileManager.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
                try fileManager.unzipItem(at: sourceURL, to: baseURL)
            } catch {
                print("Extraction of ePub file failed with error: \(error)")
                return nil
            }
        }
        // parse ePub file
        return EPUBBook(identifier: identifier, contentsOf: baseURL)
    }
}

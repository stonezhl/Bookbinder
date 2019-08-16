//
//  Bookbinder.swift
//  Bookbinder
//
//  Created by Stone Zhang on 5/1/19.
//  Copyright © 2019 Stone Zhang. All rights reserved.
//

import ZIPFoundation

public class Bookbinder {
    public let configuration: BookbinderConfiguration

    public init(configuration: BookbinderConfiguration? = nil) {
        self.configuration = configuration ?? BookbinderConfiguration()
    }

    public func bindBook(at sourceURL: URL, identifier: String? = nil) -> EPUBBook? {
        return bindBook(at: sourceURL, to: EPUBBook.self, identifier: identifier)
    }

    public func bindBook<T>(at sourceURL: URL, to type: T.Type, identifier: String? = nil) -> T? where T: EPUBBook {
        let identifier = identifier ?? sourceURL.deletingPathExtension().lastPathComponent
        let baseURL = configuration.rootURL.appendingPathComponent(identifier)
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: baseURL.path) == false {
            do {
                // unzip ePub file
                try fileManager.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
                try fileManager.unzipItem(at: sourceURL, to: baseURL)
            } catch {
                print("Extraction of the ePub file failed with error: \(error)")
                return nil
            }
        }
        // parse ePub file
        return T(identifier: identifier, contentsOf: baseURL)
    }
}

//
//  EmailAppURLBuilder.swift
//  
//
//  Created by Alex Kostenko on 11.01.2023.
//

import Foundation

/// URL builder
public struct EmailAppURLBuilder {
    public let urlStart: String
    public let queryItems: [URLQueryItem]

    /// Initializer
    /// - Parameters:
    ///   - urlStart: Start of the URL
    ///   - queryItems: Query items to append
    public init(urlStart: String, queryItems: [URLQueryItem]) {
        self.urlStart = urlStart
        self.queryItems = queryItems
    }

    /// Builds the URL by appending `queryItems` with non nil value to `urlStart`.
    /// - Returns: The final URL, if `URLComponents` can consturct valid URL
    public func build() -> URL? {
        var components = URLComponents(string: urlStart)
        let filteredItems = queryItems.filter {
            $0.value != nil
        }
        if !filteredItems.isEmpty {
            components?.queryItems = filteredItems
        }
        return components?.url
    }
}

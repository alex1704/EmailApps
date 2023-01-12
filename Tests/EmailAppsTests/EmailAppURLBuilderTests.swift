//
//  EmailAppURLBuilderTests.swift
//  
//
//  Created by Alex Kostenko on 11.01.2023.
//

import XCTest
@testable import EmailApps

final class EmailAppURLBuilderTests: XCTestCase {
    func testQueryItemsPresence() throws {
        // given when
        let items: [URLQueryItem] = [.init(name: "x", value: "1"), .init(name: "x", value: nil)]

        // then
        for item in items {
            let url = try XCTUnwrap(EmailAppURLBuilder(urlStart: "mailto:", queryItems: [item]).build())
            let components = try XCTUnwrap(URLComponents(url: url, resolvingAgainstBaseURL: false))
            if item.value == nil {
                XCTAssert(components.queryItems == nil)
                XCTAssert(url.absoluteString.first(where: { $0 == "?"}) == nil)
            } else {
                let expected = try XCTUnwrap(components.queryItems?.first)
                XCTAssert(item == expected, "\(item) != \(expected)")
            }
        }

    }
}

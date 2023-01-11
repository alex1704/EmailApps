//
//  URLQueryItem+Name.swift
//  
//
//  Created by Alex Kostenko on 11.01.2023.
//

import Foundation

extension URLQueryItem {
    /// URL query name constants
    public enum Name {
        public static let EmailSubject = "subject"
        public static let EmailBody = "body"
        public static let EmailTo = "to"
        public static let EmailRecipient = "recipient"
    }
}

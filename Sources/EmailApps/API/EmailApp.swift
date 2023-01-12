//
//  EmailApp.swift
//  
//
//  Created by Alex Kostenko on 11.01.2023.
//

import UIKit

/// Email app protocol definition
public protocol EmailApp {
    /// Name of the email app.
    var name: String { get set }
    /// URL scheme of the email app.
    var urlScheme: String { get set }
    /// URL path of the email app
    var urlPath: String { get set }
    /// A Boolean value indicating whether the email app is supported on the current device.
    var isSupported: Bool { get }
    /// Creates URL to open email app. Opened app will present new email with the specified email, subject, and body fields.
    ///
    /// - Parameters:
    ///   - email: The email address to send the message to.
    ///   - subject: The subject of the message.
    ///   - body: The body of the message.
    /// - Returns: A URL that can be used to compose an email in the app, or nil if
    ///  `URLComponents` fails to create vaild URL. By specification there is no check if email app is supported in
    ///  this function.
    func url(email: String, subject: String?, body: String?) -> URL?
}

extension EmailApp {
    /// Checks if the email app is supported on the current device.
    public var isSupported: Bool {
        guard let url = URL(string: "\(urlScheme):") else {
            return false
        }

        return UIApplication.shared.canOpenURL(url)
    }

    /// URL first part formed by `urlScheme` and `urlPath`
    public var urlPrefix: String {
        "\(urlScheme):\(urlPath)"
    }
}

public enum EmailApps {
    /// List known email apps
    public static var all: [any EmailApp] {
        [Proton(), Gmail(), Outlook(), Yahoo(), Spark(), Default()]
    }

    /// List supported email apps
    public static var supported: [any EmailApp] {
        all.filter { $0.isSupported }
    }

    /// Proton email app definition
    public struct Proton: EmailApp {
        public var name = "Proton"
        public var urlScheme = "protonmail"
        public var urlPath = "//mailto:"

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: "\(urlPrefix)\(email)",
                queryItems: [.init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }

    /// Gmail email app definition
    public struct Gmail: EmailApp {
        public var name = "Gmail"
        public var urlScheme = "googlegmail"
        public var urlPath = "//co"

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: urlPrefix,
                queryItems: [.init(name: URLQueryItem.Name.EmailTo, value: email),
                             .init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }

    /// Outlook email app definition
    public struct Outlook: EmailApp {
        public var name = "Outlook"
        public var urlScheme = "ms-outlook"
        public var urlPath = "//compose"

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: urlPrefix,
                queryItems: [.init(name: URLQueryItem.Name.EmailTo, value: email),
                             .init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }

    /// Yahoo email app definition
    public struct Yahoo: EmailApp {
        public var name = "Yahoo"
        public var urlScheme = "ymail"
        public var urlPath = "//mail/compose"

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: urlPrefix,
                queryItems: [.init(name: URLQueryItem.Name.EmailTo, value: email),
                             .init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }

    /// Spark email app definition
    public struct Spark: EmailApp {
        public var name = "Spark"
        public var urlScheme = "readdle-spark"
        public var urlPath = "//compose"

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: urlPrefix,
                queryItems: [.init(name: URLQueryItem.Name.EmailRecipient, value: email),
                             .init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }

    /// Default Apple email app definition
    public struct Default: EmailApp {
        public var name = "Mail"
        public var urlScheme = "mailto"
        /// In default app path is empty
        public var urlPath = ""

        public init() {}

        /// See method description in EmailApp protocol
        public func url(email: String, subject: String?, body: String?) -> URL? {
            EmailAppURLBuilder(
                urlStart: "\(urlPrefix)\(email)",
                queryItems: [.init(name: URLQueryItem.Name.EmailSubject, value: subject),
                             .init(name: URLQueryItem.Name.EmailBody, value: body)]
            ).build()
        }
    }
}

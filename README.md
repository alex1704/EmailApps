# EmailApps

Light weight package to list available email app clients and construct URL in order to open them on iOS device. See usage [example](https://github.com/alex1704/EmailAppsExample).

### Setup

iOS project Info.plist need to be updated with email app url schemes which can be opened on iOS device. For example:
```
<key>LSApplicationQueriesSchemes</key>
<array>
		<string>protonmail</string>
		<string>googlegmail</string>
		<string>ms-outlook</string>
		<string>readdle-spark</string>
		<string>ymail</string>
</array>
```
**Warning: works only on iOS devices**

### API

Currently library support next apps - Proton, Gmail, Outlook, Yahoo, Spark, Mail (default iOS app) which can be accessed from `EmailApps` enum. For example, `EmailApps.Proton()`. Each entity implements `EmailApp` protocol:
```swift
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
```

Additionally, `EmailApps` has convenience methods:
```swift
/// List known email apps
public static var all: [any EmailApp]

/// List supported email apps
public static var supported: [any EmailApp]
```

### Extensibility

In order to add support for new email app, introduced entiry has to adopt `EmailApp` protocol. For example:
```swift
public struct Sparrow: EmailApp {
  public var name = "Sparrow"
  public var urlScheme = "sparrow"
  public var urlPath = ""

  /// See method description in EmailApp protocol
  public func url(email: String, subject: String?, body: String?) -> URL? {
    EmailClientURLBuilder(
      urlStart: "\(urlPrefix)\(email)",
      queryItems: [.init(name: URLQueryItem.Name.EmailSubject, value: subject),
                   .init(name: URLQueryItem.Name.EmailBody, value: body)]
    ).build()
  }
}
```

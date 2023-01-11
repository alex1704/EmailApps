import XCTest
@testable import EmailApps

final class EmailAppsTests: XCTestCase {
    func testEmailAppsProduceValidURLs() throws {
        // given
        let apps = EmailApps.all

        // when
        let emails = ["example@gmail.com", ""]
        let subject = "This is non nil subject."
        let body = "This is non nil body."

        // then
        for app in apps {
            for email in emails {
                _ = try XCTUnwrap(app.url(email: email, subject: nil, body: nil), "App: \(app.name)")
            }

            _ = try XCTUnwrap(app.url(email: "", subject: subject, body: nil), "App: \(app.name)")
            _ = try XCTUnwrap(app.url(email: "", subject: nil, body: body), "App: \(app.name)")
            _ = try XCTUnwrap(app.url(email: "", subject: subject, body: body), "App: \(app.name)")
        }
    }

    func testEmailAppsURLPrefix() throws {
        // given
        let apps = EmailApps.all

        // when
        let email = "xxx@email.com"

        // then
        for app in apps {
            let url = try XCTUnwrap(app.url(email: email, subject: nil, body: nil), "App: \(app.name)")
            XCTAssert(url.scheme == app.urlScheme)
            let prefix0 = try XCTUnwrap(url.absoluteString.components(separatedBy: email).first)
            let prefix1 = try XCTUnwrap(prefix0.components(separatedBy: "?").first)
            XCTAssert(prefix1 == app.urlPrefix, "\(prefix1) not equal to \(app.urlPrefix)")
        }
    }
}

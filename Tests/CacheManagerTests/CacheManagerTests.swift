import XCTest
@testable import CacheManager

final class CacheManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CacheManager().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

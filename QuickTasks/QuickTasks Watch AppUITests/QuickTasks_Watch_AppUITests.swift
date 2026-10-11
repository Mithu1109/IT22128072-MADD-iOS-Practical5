import XCTest

final class QuickTasks_Watch_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["Quick Tasks"].exists || app.navigationBars["Quick Tasks"].exists)
    }
}

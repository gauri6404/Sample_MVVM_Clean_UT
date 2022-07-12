import XCTest

class MoviesSceneUITests: XCTestCase {

    override func setUp() {

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    
    func testScreenUI() {
        let app = XCUIApplication()
        
        // Search field exist
        XCTAssertTrue(app.searchFields[AccessibilityIdentifier.searchField].exists)
        
        // Title exist
        XCTAssertTrue(app.staticTexts["Movies"].exists)
        
        // Search for Batman
        let searchText = "Batman Begins"
        app.searchFields[AccessibilityIdentifier.searchField].tap()
        if !app.keys["A"].waitForExistence(timeout: 5) {
            XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        }
        _ = app.searchFields[AccessibilityIdentifier.searchField].waitForExistence(timeout: 10)
        app.searchFields[AccessibilityIdentifier.searchField].typeText(searchText)
        app.buttons["search"].tap()
        
        // Table view exist
        XCTAssertTrue(app.tables[AccessibilityIdentifier.tableView].waitForExistence(timeout: 5))
    }
}

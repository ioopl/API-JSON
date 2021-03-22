import XCTest

class API_JSONUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testTabBarItemsExistsAndIsTappable() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBarView1 = app.staticTexts["Latest"]
        XCTAssert(tabBarView1.exists)
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        let tabBarView2 = app.staticTexts["Upcomming"]
        XCTAssert(tabBarView2.exists)
        
    }

    override func tearDownWithError() throws {
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

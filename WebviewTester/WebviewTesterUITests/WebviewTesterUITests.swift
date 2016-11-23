//
//  WebviewTesterUITests.swift
//  WebviewTesterUITests
//
//  Created by Brian Reinhart on 11/10/16.
//  Copyright © 2016 Koupon Media. All rights reserved.
//

import XCTest

class WebviewTesterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice().orientation = UIDeviceOrientation.portrait;
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*func testEmptyURLShouldShowAlert() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["Clear text"].tap()
        let myurlTextField = app.textFields["myURL"]
        myurlTextField.tap()
        
        let btnLoadUrl = app.buttons["btnLoadUrl"]
        btnLoadUrl.tap()
        XCTAssert(app.alerts["Oops"].exists)
        app.alerts["Oops"].buttons["My Bad!"].tap()
        //Dialog should dissappear.
        XCTAssert(app.alerts["Oops"].exists == false)
        
    }*/
    
    func testUIWebView() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.buttons["Clear text"].tap()
        app.textFields["myURL"].typeText("google.com")
        app.buttons["UIWebView"].tap()
        app.switches["cbCookies"].tap()
        app.buttons["btnLoadUrl"].tap()
        
        //Wait for GOogle.com to load
        let webPageTitle = app.otherElements["Google"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: webPageTitle, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        //Continue testing
        let toolbar = app.toolbars
        //Make sure that the forward button cannot be pressed
        XCTAssert(toolbar.buttons["imageForward"].isEnabled == false)
        
        /*
         * UI Tests were failing when trying to type text into the search box.  Tried a few workarounds, but nothing seems to work.
         * Will do some research and come back to this.
         *
            //Search for something
            let searchElement = app.otherElements["search"].otherElements["Search"]
            XCTAssert(searchElement.exists)
            searchElement.tap()
            app.typeText("apple\r")
            
            
            //Make sure we can now hit the back button.
            XCTAssert(toolbar.buttons["imageBack"].isEnabled)
            toolbar.buttons["imageBack"].tap()
            
            //Make sure the forward button is now enabled
            XCTAssert(toolbar.buttons["imageForward"].isEnabled)
            toolbar.buttons["imageForward"].tap()
            
            //Make sure that Done button can be hit.
            XCTAssert(toolbar.buttons["Done"].exists)
            toolbar.buttons["Done"].tap()
        */
        
    }
    
}

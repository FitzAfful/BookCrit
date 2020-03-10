//
//  BookCritUITests.swift
//  BookCritUITests
//
//  Created by Fitzgerald Afful on 09/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest

class AuthenticationUITests: XCTestCase {


    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
    }

    func testEmailSignUp() {
        app.launch()
        app.buttons["sign up"].tap()
        let nameTF = app.textFields["Name"]
        nameTF.tap()
        nameTF.typeText("Kwesi Redding")

        let emailTF = app.textFields["Email Address"]
        emailTF.tap()
        emailTF.typeText("kwesiredding@gmail.com")

        let passwordTF = app.secureTextFields["Password"]
        passwordTF.tap()
        passwordTF.typeText("gerald")
        
        app.buttons.containing(.staticText, identifier:"SIGN UP").element.tap()

        let alert = app.alerts["Success"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "Successful Registration"))
    }


    func testEmailLogin() {
        app.launch()
        let emailTF = app.textFields["Email Address"]
        emailTF.tap()
        emailTF.typeText("kwesiredding@gmail.com")

        let passwordTF = app.secureTextFields["Password"]
        passwordTF.tap()
        passwordTF.typeText("gerald")

        app.buttons.containing(.staticText, identifier:"LOG IN").element.tap()

        let alert = app.alerts["Success"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "Successful Login"))
    }

    func testForgotPassword(){
        
    }
}

extension XCUIElement {
  func labelContains(text: String) -> Bool {
    let predicate = NSPredicate(format: "label CONTAINS %@", text)
    return staticTexts.matching(predicate).firstMatch.exists
  }
}


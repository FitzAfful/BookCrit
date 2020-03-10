//
//  BookCritUITests.swift
//  BookCritUITests
//
//  Created by Fitzgerald Afful on 09/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest

class AuthenticationUITests: XCTestCase {

    let userName = "Kwesi Redding"
    let userEmail = "kwesiredding@gmail.com"
    let userPassword = "gerald"
    let wrongUserPassword = "geraldo"
    let existsPredicateString = "exists == 1"

    let emailPlaceholder = "Email Address"
    let successPlaceholder = "Success"
    let errorPlaceholder = "Error"
    let passwordPlaceholder = "Password"

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
    }

    func testEmailCreateAccount() {
        app.launch()
        app.buttons["sign up"].tap()
        let nameTF = app.textFields["Name"]
        nameTF.tap()
        nameTF.typeText(userName)

        let emailTF = app.textFields[emailPlaceholder]
        emailTF.tap()
        emailTF.typeText(userEmail)

        let passwordTF = app.secureTextFields[passwordPlaceholder]
        passwordTF.tap()
        passwordTF.typeText(userPassword)
        
        app.buttons.containing(.staticText, identifier:"SIGN UP").element.tap()

        let alert = app.alerts[successPlaceholder]
        let exists = NSPredicate(format: existsPredicateString)

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "Successful Registration"))
    }


    func testEmailLogin() {
        app.launch()
        let emailTF = app.textFields[emailPlaceholder]
        emailTF.tap()
        emailTF.typeText(userEmail)

        let passwordTF = app.secureTextFields[passwordPlaceholder]
        passwordTF.tap()
        passwordTF.typeText(userPassword)

        app.buttons.containing(.staticText, identifier:"LOG IN").element.tap()

        let alert = app.alerts[successPlaceholder]
        let exists = NSPredicate(format: existsPredicateString)

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "Successful Login"))
    }

    func testForgotPassword(){
        app.launch()
        app.buttons["Forgot Password"].tap()
        let emailTF = app.textFields[emailPlaceholder]
        emailTF.tap()
        emailTF.typeText(userEmail)

        app.buttons.containing(.staticText, identifier:"RESET PASSWORD").element.tap()

        let alert = app.alerts[successPlaceholder]
        let exists = NSPredicate(format: existsPredicateString)

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "A reset email has been sent to your email address. Please check and follow the instructions shown"))
    }

    func testEmailCreateAccount_UserAlreadyExists(){
        app.launch()
        app.buttons["sign up"].tap()
        let nameTF = app.textFields["Name"]
        nameTF.tap()
        nameTF.typeText(userName)

        let emailTF = app.textFields[emailPlaceholder]
        emailTF.tap()
        emailTF.typeText(userEmail)

        let passwordTF = app.secureTextFields[passwordPlaceholder]
        passwordTF.tap()
        passwordTF.typeText(userPassword)

        app.buttons.containing(.staticText, identifier:"SIGN UP").element.tap()

        let alert = app.alerts[errorPlaceholder]
        let exists = NSPredicate(format: existsPredicateString)

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "An account with this email already exists. Please log in!"))
    }

    func testEmailLoginWithWrongCredentials(){
        app.launch()
        let emailTF = app.textFields[emailPlaceholder]
        emailTF.tap()
        emailTF.typeText(userEmail)

        let passwordTF = app.secureTextFields[passwordPlaceholder]
        passwordTF.tap()
        passwordTF.typeText(wrongUserPassword)

        app.buttons.containing(.staticText, identifier:"LOG IN").element.tap()

        let alert = app.alerts[errorPlaceholder]
        let exists = NSPredicate(format: existsPredicateString)

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 20.0, handler: nil)

        XCTAssert(alert.labelContains(text: "You entered an invalid password please try again!"))
    }
}

extension XCUIElement {
    func labelContains(text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        return staticTexts.matching(predicate).firstMatch.exists
    }
}


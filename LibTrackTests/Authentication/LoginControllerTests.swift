//
//  AuthenticationUnitTests.swift
//  LibTrackTests
//
//  Created by Fitzgerald Afful on 10/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest
@testable import LibTrack

class LoginControllerTests: XCTestCase {

    var loginController : LoginController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        loginController = (storyboard.instantiateInitialViewController() as! LoginController)
        loginController.loadView()
    }

    func test_loginWithWrongEmailAddress() {
        loginController.emailTF.text = "kwesiredding"
        loginController.passwordTF.text = "geraldo"
        loginController.signInEmail(loginController.bgView!)
        XCTAssertEqual(loginController.emailTF!.errorText, "Enter a valid email address")
    }

    func test_loginWithEmptyPassword() {
        loginController.emailTF.text = "kwesiredding@gmail.com"
        loginController.passwordTF.text = ""
        loginController.signInEmail(loginController.bgView!)
        XCTAssertEqual(loginController.passwordTF!.errorText, "Enter your password")
    }

    func test_loginWithEmptyEmailAddress() {
        loginController.emailTF.text = ""
        loginController.passwordTF.text = "gerald"
        loginController.signInEmail(loginController.bgView!)
        XCTAssertEqual(loginController.emailTF!.errorText, "Enter a valid email address")
    }

    func test_isValidEmail(){
        let emailAddress = "kofi"
        XCTAssertFalse(emailAddress.isValidEmail())
    }

}

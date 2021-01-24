//
//  AuthenticationUnitTests.swift
//  LibTrackTests
//
//  Created by Fitzgerald Afful on 10/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest
@testable import LibTrack

class ForgotPasswordTests: XCTestCase {

    var forgotPasswordController : ForgotPassController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        forgotPasswordController = (storyboard.instantiateViewController(withIdentifier: "ForgotPassController")  as! ForgotPassController)
        forgotPasswordController.loadView()
    }

    func test_loginWithWrongEmailAddress() {
        forgotPasswordController.emailTF.text = "kwesiredding"
        forgotPasswordController.resetPassword(forgotPasswordController.bgView!)
        XCTAssertEqual(forgotPasswordController.emailTF!.errorText, "Enter a valid email address")
    }

    func test_loginWithEmptyEmailAddress() {
        forgotPasswordController.emailTF.text = ""
        forgotPasswordController.resetPassword(forgotPasswordController.bgView!)
        XCTAssertEqual(forgotPasswordController.emailTF!.errorText, "Enter a valid email address")
    }

    func test_isValidEmail(){
        let emailAddress = "kofi"
        XCTAssertFalse(emailAddress.isValidEmail())
    }

}

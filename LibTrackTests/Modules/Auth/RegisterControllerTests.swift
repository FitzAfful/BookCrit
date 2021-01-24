//
//  AuthenticationUnitTests.swift
//  LibTrackTests
//
//  Created by Fitzgerald Afful on 10/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest
@testable import LibTrack

class RegisterControllerTests: XCTestCase {

    var registerController : RegisterController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        registerController = (storyboard.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController)
        registerController.loadView()
    }

    func test_loginWithWrongEmailAddress() {
        registerController.emailTF.text = "kwesiredding"
        registerController.nameTF.text = "Gerald"
        registerController.passwordTF.text = "geraldo"
        registerController.registerEmail(registerController.bgView!)
        XCTAssertEqual(registerController.emailTF!.errorText, "Enter a valid email address")
    }

    func test_loginWithEmptyPassword() {
        registerController.emailTF.text = "kwesiredding@gmail.com"
        registerController.nameTF.text = "Gerald"
        registerController.passwordTF.text = ""
        registerController.registerEmail(registerController.bgView!)
        XCTAssertEqual(registerController.passwordTF!.errorText, "Enter your password")
    }

    func test_loginWithEmptyEmailAddress() {
        registerController.emailTF.text = ""
        registerController.nameTF.text = "Gerald"
        registerController.passwordTF.text = "gerald"
        registerController.registerEmail(registerController.bgView!)
        XCTAssertEqual(registerController.emailTF!.errorText, "Enter a valid email address")
    }


}

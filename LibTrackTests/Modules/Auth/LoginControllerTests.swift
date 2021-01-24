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
        loginController = (storyboard.instantiateInitialViewController() as! LoginController)
        loginController.loadView()
    }


}

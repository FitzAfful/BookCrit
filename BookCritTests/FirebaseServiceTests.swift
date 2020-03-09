//
//  AuthenticationUsecaseTests.swift
//  BookCritTests
//
//  Created by Fitzgerald Afful on 09/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import XCTest
import Firebase
@testable import BookCrit

class AuthenticationModelTests: XCTestCase {

    private let userEmail = "fitzafful@gmail.com"
    private let userName = "Gerald Afful"
    private let userBirthdate = Date()
    private let userPassword = "gerald"
    private var firAuth: Auth = {
        if FirebaseApp.app() == nil { FirebaseApp.configure() }
        return Auth.auth()
    }()
    private var service: FirebaseServiceProtocol!

    override func setUp() {
        service = FirebaseServiceStub()
    }

    func testFirebaseEmailLogin(){
        let user = firAuth.currentUser
        service.registerUser(with: <#T##String#>, password: <#T##String#>, name: <#T##String#>, completion: <#T##(AuthDataResult?, Error?) -> Void#>)
        let longRunningExpectation = expectation(description: "LoginWithEmail")
        var authenticationError: AuthenticationError?
        var createdUser: User?

        interactor.firebaseEmailLogin(with: userEmail, password: userPassword, name: userName)
    }

    func testFirebaseAppleLogin(){

    }

    func testForgotPassword(){

    }

}

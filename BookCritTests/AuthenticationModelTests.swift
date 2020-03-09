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
    private var interactor: AuthInteractor!

    override func setUp() {
        interactor = AuthInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func firebaseGoogleLogin(with googleUser: GIDGoogleUser)
    func firebaseEmailLogin(with email: String, password: String, name: String)
    func firebaseAppleLogin(with idToken: String, nonce: String)
    func firebaseEmailRegister(with email: String, password: String, name: String)
    func forgotPassword(with email: String)


    func testFirebaseEmailLogin(){
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

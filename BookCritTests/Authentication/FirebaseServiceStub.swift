//
//  FirebaseServiceStub.swift
//  BookCritTests
//
//  Created by Fitzgerald Afful on 09/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import XCTest
import Firebase
@testable import BookCrit

class FirebaseServiceStub: FirebaseServiceProtocol {
    var registerResult: (AuthDataResult?, Error?)?
    var registeredUser: User?

    func registerUser(with email: String, password: String, name: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        guard let registerResult = registerResult else { return }
        if let _ = registerResult.1 {
            registeredUser = nil
        } else {
            registeredUser = nil
        }

        completion(registerResult.0, registerResult.1)
    }

    func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        
    }

    func loginUser(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?) -> Void) {
    }
}

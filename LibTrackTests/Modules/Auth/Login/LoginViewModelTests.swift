//
//  LoginViewModelTests.swift
//  LibTrackTests
//
//  Created by Hosny Savage on 29/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import XCTest
import GoogleSignIn
import Firebase

class LoginViewModelTests: XCTestCase {

    func firebaseGoogleLoginTests() {
        var googleUser: GIDGoogleUser = GIDGoogleUser()
        
        let credential = firebaseService.getCredentialFromGoogle(with: googleUser)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result)
            
        }
        XCTAssertEqual()
    }
    
    
        
    
}

//
//  LoginViewModel.swift
//  LibTrack
//
//  Created by Hosny Savage on 12/01/2021.
//  Copyright © 2021 Glivion. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

class LoginViewModel {

    var firebaseService = FirebaseService()

    func firebaseGoogleLogin(with googleUser: GIDGoogleUser, completion: @escaping (String?) -> Void) {
        let credential = firebaseService.getCredentialFromGoogle(with: googleUser)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: nil, password: nil, completion: completion)
        }
    }

    func firebaseAppleLogin(with idToken: String, nonce: String, completion: @escaping (String?) -> Void) {
        let credential = firebaseService.getCredentialFromApple(with: idToken, nonce: nonce)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: nil, password: nil, completion: completion)
        }
    }


    func signedIn(error: Error?, result: FirebaseAuthResult?, name: String?, email: String?, password: String?, completion: @escaping (String?) -> Void) {
        if error != nil {
            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                switch errorCode {
                case.wrongPassword:
                    completion("You entered an invalid password please try again!")
                case .weakPassword:
                    completion("You entered a weak password. Please choose another!")
                case .emailAlreadyInUse:
                    completion("An account with this email already exists. Please log in!")
                case .accountExistsWithDifferentCredential:
                    completion("This account exists with different credentials")
                default:
                    completion("Unexpected error \(errorCode.rawValue) please try again!")
                }
            }
            return
        }

        if email != nil {
            firebaseService.updateCurrentUserDetails(email: email!, name: name!, photoURL: "https://example.com/jane-q-user/profile.jpg")
        }

//        completion(nil)
    }

}

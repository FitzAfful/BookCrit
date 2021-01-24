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
    var cryptHelper = CryptHelper()
    var nonce: String?
    var view: LoginController

    init(view: LoginController) {
        self.view = view
    }

    func firebaseGoogleLogin(with googleUser: GIDGoogleUser) {
        let credential = firebaseService.getCredentialFromGoogle(with: googleUser)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result)
        }
    }

    func firebaseAppleLogin(with idToken: String) {
        let credential = firebaseService.getCredentialFromApple(with: idToken, nonce: nonce!)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result)
        }
    }

    func signedIn(error: Error?, result: FirebaseAuthResult?) {
        var errorMessage: String?
        if error != nil {
            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                switch errorCode {
                case.wrongPassword:
                    errorMessage = "You entered an invalid password please try again!"
                case .weakPassword:
                    errorMessage = "You entered a weak password. Please choose another!"
                case .emailAlreadyInUse:
                    errorMessage = "An account with this email already exists. Please log in!"
                case .accountExistsWithDifferentCredential:
                    errorMessage = "This account exists with different credentials"
                default:
                    errorMessage = "Unexpected error \(errorCode.rawValue) please try again!"
                }
            }
        }
        if let message = errorMessage {
            self.view.showAlert(title: "Error", message: message)
            return
        }
        // sign in successful move to next screen
    }

    func get256Sha() -> String {
        self.nonce = cryptHelper.randomNonceString()
        return cryptHelper.sha256(self.nonce!)
    }

}

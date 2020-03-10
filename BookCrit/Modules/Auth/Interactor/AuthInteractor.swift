//
//  LoginInteractor.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

class AuthInteractor: AuthUseCase {

    var output: AuthInteractorOutput!
    var firebaseService = FirebaseService()

    func firebaseGoogleLogin(with googleUser: GIDGoogleUser) {
        let credential = firebaseService.getCredentialFromGoogle(with: googleUser)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: nil, password: nil)
        }
    }

    func firebaseAppleLogin(with idToken: String, nonce: String) {
        let credential = firebaseService.getCredentialFromApple(with: idToken, nonce: nonce)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: nil, password: nil)
        }
    }

    func firebaseEmailLogin(with email: String, password: String, name: String) {
        let credential = firebaseService.getCredentialFromEmail(with: email, password: password)
        firebaseService.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: nil, password: nil)
        }
    }

    func firebaseEmailRegister(with email: String, password: String, name: String) {
        firebaseService.registerUser(with: email, password: password, name: name) { (result, error) in
            self.signedIn(error: error, result: result, name: name, email: email, password: password)
        }
    }

    func forgotPassword(with email: String) {
        firebaseService.forgotPassword(with: email) { (error) in
            if error != nil {
                self.output.onForgotPasswordFailure(message: error!.localizedDescription)
                return
            }
            self.output.onForgotPasswordSuccess()
        }
    }

    func signedIn(error: Error?, result: FirebaseAuthResult?, name: String?, email: String?, password: String? ) {
        if error != nil {
            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                switch errorCode {
                case.wrongPassword:
                    self.output.onSignInFailure(message: "You entered an invalid password please try again!")
                case.userNotFound:
                    if let myEmail = email {
                        self.firebaseEmailRegister(with: myEmail, password: password!, name: "-")
                        return
                    } else {
                        self.output.onSignInFailure(message: "User not found. Please create an account")
                    }
                case .weakPassword:
                    self.output.onSignInFailure(message: "You entered a weak password. Please choose another!")
                case .emailAlreadyInUse:
                    self.output.onSignInFailure(message: "An account with this email already exists. Please log in!")
                case .accountExistsWithDifferentCredential:
                    self.output.onSignInFailure(message: "This account exists with different credentials")
                default:
                    self.output.onSignInFailure(message: "Unexpected error \(errorCode.rawValue) please try again!")
                }
            }
            return
        }

        if email != nil {
            firebaseService.updateCurrentUserDetails(email: email!, name: name!, photoURL: "https://example.com/jane-q-user/profile.jpg")
        }

        self.output.onSignInSuccess()
    }

}

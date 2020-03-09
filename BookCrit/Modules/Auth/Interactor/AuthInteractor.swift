//
//  LoginInteractor.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

class AuthInteractor: AuthUseCase {

    var output: AuthInteractorOutput!
    func firebaseGoogleLogin(with googleUser: GIDGoogleUser) {
        let authentication = googleUser.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: "", password: "")
        }
    }

    func firebaseAppleLogin(with idToken: String, nonce: String) {
        print(nonce)
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: "", password: "")
        }
    }

    func firebaseEmailLogin(with email: String, password: String, name: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        print("Email Login")
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: name, email: email, password: password)
        }
    }

    func firebaseEmailRegister(with email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.signedIn(error: error, result: result, name: name, email: email, password: password)
        }
    }

    func firebaseFacebookLogin(with token: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, name: nil, email: "", password: "")
        }
    }

    func forgotPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error!.localizedDescription)
                self.output.onForgotPasswordFailure(message: error!.localizedDescription)
                return
            }
            self.output.onForgotPasswordSuccess()
        }
    }

    func signedIn(error: Error?, result: AuthDataResult?, name: String?, email: String?, password: String ) {
        if error != nil {
            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                switch errorCode {
                case.wrongPassword:
                    self.output.onSignInFailure(message: "You entered an invalid password please try again!")
                case.userNotFound:
                    print("User not found")
                    if let myEmail = email {
                        print("Email User \(password)")
                        self.firebaseEmailRegister(with: myEmail, password: password, name: "-")
                        return
                    } else {
                        print("User not found II")
                        self.output.onSignInFailure(message: "User not found. Please create an account")
                    }
                case .weakPassword:
                    self.output.onSignInFailure(message: "You entered a weak password. Please choose another!")
                case .accountExistsWithDifferentCredential:
                    self.output.onSignInFailure(message: "This account exists with different credential")
                default:
                    self.output.onSignInFailure(message: "Unexpected error \(errorCode.rawValue) please try again!")
                    print("Creating user error \(error.debugDescription)!")
                }
            }
            return
        }

        if email != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name!
                changeRequest.photoURL =
                    URL(string: "https://example.com/jane-q-user/profile.jpg")
                changeRequest.commitChanges { _ in
                }
            }
        }

        self.output.onSignInSuccess()
    }

}

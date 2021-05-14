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
import Alamofire

class LoginViewModel {

    var firebaseHelper = FirebaseHelper()
    var cryptHelper = CryptHelper()
    var nonce: String?
    var view: LoginController

    init(view: LoginController) {
        self.view = view
    }

    func firebaseGoogleLogin(with googleUser: GIDGoogleUser) {
        let credential = firebaseHelper.getCredentialFromGoogle(with: googleUser)
        firebaseHelper.loginUser(credential: credential) { (result, error) in
            self.signedIn(error: error, result: result)
        }
    }

    func firebaseAppleLogin(with idToken: String) {
        let credential = firebaseHelper.getCredentialFromApple(with: idToken, nonce: nonce!)
        firebaseHelper.loginUser(credential: credential) { (result, error) in
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
        // get verified token
        getVerifyIDToken()
    }

    func get256Sha() -> String {
        self.nonce = cryptHelper.randomNonceString()
        return cryptHelper.sha256(self.nonce!)
    }

    func signIn() {
        AuthNetworkManager.signUp { (result) in
            self.parseSignInResponse(result: result)
        }
    }

    private func parseSignInResponse(result: DataResponse<SignupResponse, AFError>) {
        switch result.result {
        case .success(let response):
            print(response)
            if response.data.username == "" || response.data.username == "null" || response.data.username == nil {
                view.moveToChooseUsernameController()
            }else {
            
            }
            break
        case .failure( _):
            break

        }
    }

    func getVerifyIDToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                // Handle error
                print("error: \(error.localizedDescription)")
                return
            }
            print("id token: \(String(describing: idToken))")
            let def: UserDefaults = UserDefaults.standard
            def.set(idToken, forKey: "idToken")
            // Send token to your backend via HTTPS
            // ...
            self.signIn()
        }
    }

}

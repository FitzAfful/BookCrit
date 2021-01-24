//
//  ViewController.swift
//  RideAlong
//
//   on 26/12/2018.
//  Copyright © 2018 RideAlong. All rights reserved.
//

import UIKit
import FTIndicator
import GoogleSignIn
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class LoginController: BaseViewController, GIDSignInDelegate, LoginViewDelegate {

    var loginView: LoginView?
    var loginMdoel: LoginViewModel = LoginViewModel()

    fileprivate var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        loginView = LoginView(delegate: self)
        if let login = loginView {
            self.view.addSubview(login)
            login.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }

    func googleButtonTapped() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }

    func appleButtonTapped() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        startLoader()
        if error != nil {
            cancelLoader()
            self.showAlert(title: "Error", message: "Could not sign in. Please try again later.")
            return
        }

        self.loginMdoel.firebaseGoogleLogin(with: user, completion: { (errorMessage) in
            if errorMessage == nil {
                // something was successful
            }
        })
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    func presentHomeScreen() {
        FTIndicator.dismissProgress()
        self.showAlert(title: "Success", message: "Successful Login")
        // Move to Tabs / Search
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }
}

@available(iOS 13.0, *)
extension LoginController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}

@available(iOS 13.0, *)
extension LoginController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            loginMdoel.firebaseAppleLogin(with: idTokenString, nonce: nonce) { (errorMessage) in
                if errorMessage == nil {
                    // success
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

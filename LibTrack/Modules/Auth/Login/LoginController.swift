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
import AuthenticationServices

class LoginController: BaseViewController, GIDSignInDelegate, LoginViewDelegate {

    var loginView: LoginView?
    var loginModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginModel = LoginViewModel(view: self)

        createViews()
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        loginView = LoginView(delegate: self)
        view.backgroundColor = UIColor(hex: "#000000")
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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = loginModel?.get256Sha()

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        startLoader()
        if error != nil {
            self.showAlert(title: "Error", message: "Could not sign in. Please try again later.")
            return
        }
//        cancelLoader()
        self.loginModel?.firebaseGoogleLogin(with: user)
        if let navigationControl = navigationController as? AuthNavigationController {
            navigationControl.navigate(.createUsername)
        }
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
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            loginModel?.firebaseAppleLogin(with: idTokenString)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

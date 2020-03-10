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

class LoginController: UIViewController, GIDSignInDelegate, UITextFieldDelegate, LoginView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var appleImageView: UIImageView!

    @IBOutlet weak var emailTF: ACFloatingTextfield!
    @IBOutlet weak var passwordTF: ACFloatingTextfield!
    fileprivate var currentNonce: String?

    var presenter: AuthPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        bgView.layer.cornerRadius = 15
        bgView.layer.shadowColor = UIColor(hex: "#7E7E7E").cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowRadius = 4.0

        emailTF.delegate = self
        passwordTF.delegate = self

        let googleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.signInGoogle))
        googleView.addGestureRecognizer(googleViewTap)
        googleView.isUserInteractionEnabled = true

        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.handleViewTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture2)

        appleImageView.tappable = true
        appleImageView.callback = {
            self.signInApple()
        }
    }

    @objc func handleViewTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        startLoader()
        if error != nil {
            cancelLoader()
            self.showCustomError("Could not sign in. Please try again later.")
            return
        }
        self.presenter.didLoginWithGoogle(user)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTF {
            self.view.endEditing(true)
            self.signInEmail(self.passwordTF!)
        } else {
            _ = passwordTF.becomeFirstResponder()
        }
        return true
    }

    @objc func signInGoogle() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func signInEmail(_ sender: Any) {
        let email = self.emailTF.text!
        let password = self.passwordTF.text!

        if email.isEmpty {
            self.emailTF.showErrorWithText(errorText: "Enter a valid email address")
        } else if password.isEmpty {
            self.passwordTF.showErrorWithText(errorText: "Enter your password")
        } else if email.isValidEmail() {
            startLoader()
            self.presenter.didLoginWithEmail(email, password: password, name: "")
        } else {
            emailTF.showErrorWithText(errorText: "Enter a valid email address")
        }
    }

    func signInApple() {
        if #available(iOS 13, *) {
            startSignInWithAppleFlow()
        }
    }

    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
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

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    func cancelLoader() {
        FTIndicator.dismissProgress()
    }

    func startLoader() {
        FTIndicator.showProgress(withMessage: "Signing In")
    }

    func showCustomError(_ message: String?) {
        cancelLoader()
        self.showAlert(withTitle: "Error", message: message ?? "Could not sign in. Please try again later.")
    }

    func showLoginSuccess(_ message: String?) {

    }

    func showForgotPasswordSuccess(_ message: String?) {

    }

    func displayNetworkError() {

    }

    func initializeFromStoryboard() -> LoginController {
        let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: LoginController.storyboardID)
        guard let myController = controller as? LoginController else { fatalError() }
        return myController
    }

    func presentHomeScreen() {
        FTIndicator.dismissProgress()
        self.showAlert(withTitle: "Success", message: "Successful Login")
        /*let controller = TabRouter.assembleModule()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)*/
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
            presenter.didRegisterWithApple(with: idTokenString, nonce: nonce)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }

}

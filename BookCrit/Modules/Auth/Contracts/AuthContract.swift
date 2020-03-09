//
//  AuthContract.swift
//  RideAlong
//
//   on 13/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

protocol BaseView: class {
    func showCustomError(_ message: String?)
    func cancelLoader()
    func showLoginSuccess(_ message: String?)
    func displayNetworkError()
}

protocol LoginView: BaseView {
	func showForgotPasswordSuccess(_ message: String?)
    func presentHomeScreen()
}

protocol AuthPresentation: class {
	var view: LoginView? { get set }
	var interactor: AuthUseCase! { get set }
	var router: LoginWireframe! { get set }

	func viewDidLoad()
	func didClickLoginButton()
	func didLoginWithGoogle(_ googleUser: GIDGoogleUser)
	func didLoginWithEmail(_ email: String, password: String, name: String)
	func didRegisterWithEmail(_ email: String, password: String, name: String)
    func didRegisterWithApple(with idToken: String, nonce: String)
}

protocol AuthUseCase: class {
	var output: AuthInteractorOutput! { get set }
	func firebaseGoogleLogin(with googleUser: GIDGoogleUser)
	func firebaseEmailLogin(with email: String, password: String, name: String)
    func firebaseAppleLogin(with idToken: String, nonce: String)
	func firebaseEmailRegister(with email: String, password: String, name: String)
	func forgotPassword(with email: String)
}

protocol AuthInteractorOutput: class {
	func onSignInSuccess()
	func onSignInFailure(message: String)
	func onForgotPasswordSuccess()
	func onForgotPasswordFailure(message: String)
}

protocol LoginWireframe: class {
	var viewController: UIViewController? { get set }
	static func assembleModule() -> UIViewController
	func presentHomeScreen()
	func presentUpdateDetailsScreen()
	func presentSignInScreen()
}

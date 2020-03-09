//
//  AuthPresenter.swift
//  RideAlong
//
//   on 20/08/2018.
//  Copyright © 2018 Glivion. All rights reserved.
//

import Foundation
import UIKit
import FTIndicator
import GoogleSignIn

class AuthPresenter: AuthPresentation {

	var view: LoginView?
	var interactor: AuthUseCase!
	var router: LoginWireframe!

	func didClickLoginButton() {
		//Interactor.signin
	}

	func viewDidLoad() {

	}

	func didForgotPasswordWithEmail(_ email: String) {
		self.interactor.forgotPassword(with: email)
	}

	func didLoginWithGoogle(_ googleUser: GIDGoogleUser) {
		self.interactor.firebaseGoogleLogin(with: googleUser)
	}

	func didLoginWithEmail(_ email: String, password: String, name: String) {
		self.interactor.firebaseEmailLogin(with: email, password: password, name: name)
	}

	func didRegisterWithEmail(_ email: String, password: String, name: String) {
		self.interactor.firebaseEmailRegister(with: email, password: password, name: name)
	}

    func didRegisterWithApple(with idToken: String, nonce: String) {
        self.interactor.firebaseAppleLogin(with: idToken, nonce: nonce)
    }

}

extension AuthPresenter: AuthInteractorOutput {
	func onSignInSuccess() {
        print("Successful Registration")
        FTIndicator.dismissProgress()
        view?.presentHomeScreen()
	}

	func onSignInFailure(message: String) {
        print("FAILURE message")
        FTIndicator.dismissProgress()
		view?.showCustomError(message)
	}

	func onForgotPasswordSuccess() {
        print("Success message")
		view?.cancelLoader()
		view?.showForgotPasswordSuccess("")
		//view?.presentSignInScreen()
	}

	func onForgotPasswordFailure(message: String) {
		view?.showCustomError(message)
	}

}

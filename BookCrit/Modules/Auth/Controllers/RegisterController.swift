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

class RegisterController: UIViewController, GIDSignInDelegate, UITextFieldDelegate, LoginView {

	@IBOutlet weak var bgView: UIView!
	@IBOutlet weak var googleView: UIView!
	@IBOutlet weak var emailTF: ACFloatingTextfield!
	@IBOutlet weak var nameTF: ACFloatingTextfield!
	@IBOutlet weak var passwordTF: ACFloatingTextfield!
	var presenter: AuthPresenter! = AuthPresenter()
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.interactor = AuthInteractor()
		presenter.router = AuthRouter()
		presenter.interactor.output = presenter
		presenter.view = self
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
		nameTF.delegate = self

		let googleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.signInGoogle))
		googleView.addGestureRecognizer(googleViewTap)
		googleView.isUserInteractionEnabled = true

		let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.handleViewTap))
		self.view.isUserInteractionEnabled = true
		self.view.addGestureRecognizer(tapGesture2)
	}

	@objc func handleViewTap(sender: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}

	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
		if error != nil {
			self.showCustomError("Could not sign in. Please try again later.")
			return
		}
		self.presenter.didLoginWithGoogle(user)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == passwordTF {
			self.view.endEditing(true)
			self.registerEmail(self.passwordTF!)
		} else if textField == nameTF {
			_ = emailTF.becomeFirstResponder()
		} else if textField == emailTF {
			_ = passwordTF.becomeFirstResponder()
		}
		return true
	}

	@objc func signInGoogle() {
		GIDSignIn.sharedInstance().delegate = self
		GIDSignIn.sharedInstance().signIn()
	}

	@IBAction func registerEmail(_ sender: Any) {
		let email = self.emailTF.text!
		let password = self.passwordTF.text!
		let name = self.nameTF.text!
		if email.isEmpty {
			self.emailTF.showErrorWithText(errorText: "Enter a valid email address")
		} else if password.isEmpty {
			self.passwordTF.showErrorWithText(errorText: "Enter your password")
		} else if name.isEmpty {
			self.nameTF.showErrorWithText(errorText: "Enter your name")
		} else if email.isValidEmail() {
			self.startLoader()
			self.presenter.didRegisterWithEmail(email, password: password, name: name)
		} else {
			emailTF.showErrorWithText(errorText: "Enter a valid email address")
		}
	}

	func cancelLoader() {
		FTIndicator.dismissProgress()
	}

	func startLoader() {
		FTIndicator.showProgress(withMessage: "")
	}

	func showCustomError(_ message: String?) {
		cancelLoader()
		self.showAlert(withTitle: "Error", message: message ?? "Could not sign in. Please try again later.")
	}

	func showLoginSuccess(_ message: String?) {

	}

	func displayNetworkError() {

	}

	func initializeFromStoryboard() -> LoginController {
		let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: LoginController.storyboardID)
        guard let myController = controller as? LoginController else { fatalError() }
        return myController
	}

	func showForgotPasswordSuccess(_ message: String?) {
	}

    func presentHomeScreen() {
           /*let controller = TabRouter.assembleModule()
           controller.modalPresentationStyle = .fullScreen
           self.present(controller, animated: false)*/
       }
}

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

import UIKit
import FTIndicator
import GoogleSignIn
import FirebaseAuth

class ForgotPassController: UIViewController, UITextFieldDelegate, LoginView {
    func presentHomeScreen() {
        
    }

	
	@IBOutlet weak var bgView: UIView!
	@IBOutlet weak var emailTF: ACFloatingTextfield!
	var presenter: AuthPresenter! = AuthPresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.disableDarkMode()
		presenter.interactor = AuthInteractor()
		presenter.router = AuthRouter()
		presenter.interactor.output = presenter
		presenter.view = self
		setupUI()
	}
	

	func setupUI(){
		bgView.layer.cornerRadius = 15
		bgView.layer.shadowColor = UIColor(hex: "#7E7E7E").cgColor
		bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
		bgView.layer.shadowOpacity = 0.7
		bgView.layer.shadowRadius = 4.0
		emailTF.delegate = self
		disableDarkMode()
		let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.handleViewTap))
		self.view.isUserInteractionEnabled = true
		self.view.addGestureRecognizer(tapGesture2)
		
	}
	
	@objc func handleViewTap(sender: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}
	
	

	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		if(textField == emailTF){
			self.view.endEditing(true)
			self.resetPassword(self.emailTF!)
		}
		return true;
	}
	
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

	@IBAction func resetPassword(_ sender: Any) {
		let email = self.emailTF.text!
		
		if(email.isEmpty){
			self.emailTF.showErrorWithText(errorText: "Enter a valid email address")
		}else if(email.isValidEmail()){
			self.showLoader()
			self.presenter.didForgotPasswordWithEmail(email)
		}else{
			emailTF.showErrorWithText(errorText: "Enter a valid email address")
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return.lightContent // return for status bar lightcontent
	}
	
	func cancelLoader() {
		FTIndicator.dismissProgress()
	}
	
	
	func showLoader() {
		FTIndicator.showProgress(withMessage: "")
	}
	
	
	func showCustomError(_ message: String?) {
		cancelLoader()
		self.showAlert(withTitle: "Error", message: message ??  "Could not connect. Please try again later.")
	}
	
	
	func showForgotPasswordSuccess(_ message: String?) {
        print("Forgot success")
		cancelLoader()
        self.dismiss(animated: true) {
            FTIndicator.setIndicatorStyle(.dark)
            FTIndicator.showInfo(withMessage: "A reset email has been sent to your email address. Please check and follow the instructions shown")
        }
	}
	
	
	func displayNetworkError() {
		cancelLoader()
	}
	
	func showLoginSuccess(_ message: String?) {
		
	}
	
	func initializeFromStoryboard()-> ForgotPassController{
		let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: ForgotPassController.storyboardID) as! ForgotPassController
		return controller
	}
	
	
	@IBAction func dismissController(){
		self.dismiss(animated: true, completion: nil)
	}
}


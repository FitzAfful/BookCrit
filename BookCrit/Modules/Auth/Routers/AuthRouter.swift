//
//  Router.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter: LoginWireframe {
	weak var viewController: UIViewController?

	static func assembleModule() -> UIViewController {
		let view = LoginController().initializeFromStoryboard()
        view.modalPresentationStyle = .fullScreen
		let presenter = AuthPresenter()
		let interactor = AuthInteractor()
		let router = AuthRouter()
		print("null by now")
		//let navigation = UINavigationController(rootViewController: view)
		view.presenter = presenter
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.output = presenter

		router.viewController = view
		return view
	}

	func presentHomeScreen() {
		/*let controller = TabRouter.assembleModule()
		controller.modalPresentationStyle = .fullScreen
		viewController?.present(controller, animated: false)*/
	}

	func presentUpdateDetailsScreen() {
		//Show Screen to update Phone and Email 
	}

	func presentSignInScreen() {
		//Show Home Screen
		viewController?.dismiss(animated: true, completion: nil)
	}
}

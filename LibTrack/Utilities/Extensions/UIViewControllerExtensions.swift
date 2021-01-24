//
//  UIViewController.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	
	class var storyboardID : String {
		return "\(self)"
	}
	
	static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
		return appStoryboard.viewController(viewControllerClass: self)
	}
	
	func showAlert(withTitle title:String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	func disableDarkMode(){
		if #available(iOS 13.0, *) {
			// Always adopt a light interface style.
			overrideUserInterfaceStyle = .light
		}
	}
}


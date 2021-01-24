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

	func disableDarkMode() {
		if #available(iOS 13.0, *) {
			// Always adopt a light interface style.
			overrideUserInterfaceStyle = .light
		}
	}
}

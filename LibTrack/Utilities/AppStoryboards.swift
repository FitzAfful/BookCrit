//
//  AppStoryboards.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
	
	case Main, Auth
	
	var instance : UIStoryboard {
		return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
	}
	
	func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
		
		let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
		guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
			fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
		}
		
		return scene
	}
	
	func initialViewController() -> UIViewController? {
		return instance.instantiateInitialViewController()
	}
}

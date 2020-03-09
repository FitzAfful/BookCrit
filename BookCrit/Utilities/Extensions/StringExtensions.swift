//
//  StringExtensions.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation

extension String {
	
	func isValidEmail() -> Bool {
		
		let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: self)
		
	}
	
}

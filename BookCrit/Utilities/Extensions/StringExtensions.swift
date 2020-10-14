//
//  StringExtensions.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import UIKit

extension String {
	
	func isValidEmail() -> Bool {
		
		let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: self)
		
	}

    /// Function to create anattributed text with the aprams supplied
    ///
    /// - Parameters:
    ///   - fontSize: size of the attributed text
    ///   - color: color of the attributed tex
    /// - Returns: attribured text
    func formatAsAttributed(fontSize: Int, color: UIColor) -> NSAttributedString {
        let combination = NSMutableAttributedString()
        let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))]
        let partOne = NSMutableAttributedString(string: self, attributes: attributes)
        combination.append(partOne)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: combination.length))

        return combination
    }

    /// Function to create anattributed text with the aprams supplied
    ///
    /// - Parameters:
    ///   - font: font of the attributed text
    ///   - color: color of the attributed text
    /// - Returns: an attributed text
    func formatAsAttributed(font: UIFont, color: UIColor) -> NSAttributedString {
        let combination = NSMutableAttributedString()
        let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        let partOne = NSMutableAttributedString(string: self, attributes: attributes)
        combination.append(partOne)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: combination.length))

        return combination
    }
}

//
//  UIFont+Extension.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 14/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    static func regular(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "MarkPro", size: size)
    }

    static func bold(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "MarkPro-Bold", size: size)
    }

    static func light(size: Int = 16) -> UIFont {
        return self.baseFontAction(name: "MarkPro-Book", size: size)
    }

    static func baseFontAction(name: String, size: Int) -> UIFont {
        guard let customFont = UIFont(name: name, size: CGFloat(size)) else {
            return UIFont.systemFont(ofSize: CGFloat(size))
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}

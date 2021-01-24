//
//  UIImageView.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 24/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import Nuke

public typealias SimpleClosure = (() -> Void)
private var tappableKey: UInt8 = 0
private var actionKey: UInt8 = 1

extension UIImageView {

    func setImage(_ imageUrl: String) {
        if let url = URL(string: imageUrl) {
            Nuke.loadImage(with: url, into: self)
        }
    }

    @objc var callback: SimpleClosure {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! SimpleClosure
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var gesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }

    var tappable: Bool! {
        get {
            return objc_getAssociatedObject(self, &tappableKey) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.addTapGesture()
        }
    }

    fileprivate func addTapGesture() {
        if self.tappable {
            self.gesture.numberOfTapsRequired = 1
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapped() {
        callback()
    }
}

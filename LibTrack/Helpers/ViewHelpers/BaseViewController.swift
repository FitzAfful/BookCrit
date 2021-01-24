//
//  BaseViewController.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 24/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import FTIndicator

class BaseViewController: UIViewController {

    func cancelLoader() {
        FTIndicator.dismissProgress()
    }

    func startLoader(message: String = "") {
        self.view.endEditing(true)
        FTIndicator.showProgress(withMessage: message)
    }

    func showAlert(title: String, message: String, completionHandler: (() -> Void)? = nil, okButtonText: String = "Okay") {
        self.cancelLoader()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonText, style: .default, handler: {(_)  in
            if let handler = completionHandler {
                handler()
            }}
        ))
        self.present(alert, animated: true)
    }
}

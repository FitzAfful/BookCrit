//
//  SearchNavigationController.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 24/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit

class AuthNavigationController: UINavigationController {

    enum Screen {
        case login

        var viewController: BaseViewController {
            switch self {
            case .login:
                return LoginController()
            }
        }
    }

    struct UserAuthCredentials {
        var firstName: String?
        var lastName: String?
        var email: String?
    }

    func navigate(_ to: Screen) {
        DispatchQueue.main.async {
            self.pushViewController(to.viewController, animated: true)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    var userCredentials: UserAuthCredentials = UserAuthCredentials()

}

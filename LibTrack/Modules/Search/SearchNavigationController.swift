//
//  SearchNavigationController.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 24/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit

class SearchNavigationController: UINavigationController {

    enum Screen {
        case search

        var viewController: BaseViewController {
            switch self {
            case .search:
                return SearchController()
            }
        }
    }

    func navigate(_ to: Screen) {
        DispatchQueue.main.async {
            self.pushViewController(to.viewController, animated: true)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

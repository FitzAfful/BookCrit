//
//  UsernameController.swift
//  LibTrack
//
//  Created by Hosny Savage on 07/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit
import Alamofire

class CreateUsernameController: BaseViewController, CreateUsernameViewDelegate, UITextFieldDelegate {

    var createUsernameView: CreateUsernameView?
    var usernameModel: CreateUsernameViewModel?

    func createUsernameTapped() {
        if createUsernameView?.usernameTextField.text == "GeraldCOYG" {
            createUsernameView?.createErrorLabel(username: (createUsernameView?.usernameTextField.text!)!)
        } else {
            let parameter: ChooseUsernameParameter = ChooseUsernameParameter(newUsername: (createUsernameView?.usernameTextField.text!)!)
            usernameModel?.chooseUsername(chooseUsernameParameter: parameter)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameModel = CreateUsernameViewModel(view: self)
        createViews()
    }

    func moveToSelectGenreController() {
        if let navigationControl = navigationController as? AuthNavigationController {
            navigationControl.navigate(.selectGenres)
        }
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        createUsernameView = CreateUsernameView(delegate: self)
        view.backgroundColor = UIColor(hex: "#000000")
        if let username = createUsernameView {
            self.view.addSubview(username)
            username.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }

}

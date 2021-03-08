//
//  UsernameController.swift
//  LibTrack
//
//  Created by Hosny Savage on 07/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit

class CreateUsernameController: BaseViewController, CreateUsernameViewDelegate, UITextFieldDelegate {

    func createUsernameTapped() {
        print("create")
        if createUsernameView?.usernameTextField.text == "GeraldCOYG" {
            createUsernameView?.usernameTextField.showErrorWithText(errorText: "This username, \(String(describing: createUsernameView?.usernameTextField.text!)) already exists.")
        } else {
            if let navigationControl = navigationController as? AuthNavigationController {
                navigationControl.navigate(.selectGenres)
            }
        }
    }

    var createUsernameView: CreateUsernameView?

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
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

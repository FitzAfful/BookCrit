//
//  LoginView.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 24/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import IQKeyboardManagerSwift

protocol LoginViewDelegate: class {
    func googleButtonTapped()
    func appleButtonTapped()
}

class LoginView: UIView {

    let logoView = UIImageView()
    let bgView = UIImageView()
    let googleButton = UIImageView()
    let appleButton = UIImageView()

    weak var delegate: LoginViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: LoginViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createBackgroundView()
        createLogoView()
        createAppleButton()
        createGoogleButton()
    }

    func createBackgroundView() {
        bgView.image = UIImage(named: "bg3")
        bgView.contentMode = .scaleAspectFill
        bgView.clipsToBounds = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints({ (make) in
            make.left.top.bottom.right.equalToSuperview()
        })
    }

    func createLogoView() {
        logoView.image = UIImage(named: "logo_black")
        logoView.contentMode = .scaleAspectFit
        logoView.clipsToBounds = true
        self.addSubview(logoView)
        logoView.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(80)
            make.height.equalTo(100)
        })
    }

    func createGoogleButton() {
        googleButton.image = UIImage(named: "googleButton")
        googleButton.contentMode = .scaleAspectFill
        googleButton.clipsToBounds = true
        googleButton.layer.cornerRadius = 25
        googleButton.tappable = true
        googleButton.callback = {
            self.delegate?.googleButtonTapped()
        }
        self.addSubview(googleButton)
        self.bringSubviewToFront(googleButton)
        googleButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(150)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    func createAppleButton() {
        appleButton.image = UIImage(named: "apple")
        appleButton.contentMode = .scaleAspectFill
        appleButton.clipsToBounds = true
        appleButton.layer.cornerRadius = 25
        appleButton.tappable = true
        appleButton.callback = {
            self.delegate?.appleButtonTapped()
        }
        self.addSubview(appleButton)
        self.bringSubviewToFront(appleButton)
        appleButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(80)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }
}

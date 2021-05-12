//
//  UsernameView.swift
//  LibTrack
//
//  Created by Hosny Savage on 07/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol CreateUsernameViewDelegate: class {
    func createUsernameTapped()
}

class CreateUsernameView: UIView {

    let smallLogoView = UIImageView()
    let boldTextLabel = UILabel()
    let subtitleLabel = UILabel()
    let lineView = UIView()
    let usernameTextField = ACFloatingTextfield()
    let textFieldErrorLabel = UILabel()
    let usernameButton = UIButton()

    weak var delegate: CreateUsernameViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: CreateUsernameViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createSmallLogoView()
        createBoldLabel()
        createSubtitleLabel()
        createLineView()
        createUserNameTextField()
        createUsernameButton()
    }

    func createSmallLogoView() {
        smallLogoView.image = UIImage(named: "logo")
        smallLogoView.contentMode = .scaleAspectFit
        smallLogoView.clipsToBounds = true
        smallLogoView.cornerRadius = 5
        self.addSubview(smallLogoView)
        smallLogoView.snp.makeConstraints({ (make) in
            make.topMargin.equalTo(35)
            make.leftMargin.equalTo(35)
            make.height.equalTo(40)
            make.width.equalTo(40)
        })
    }

    func createBoldLabel() {
        boldTextLabel.text = "Choose Username"
        boldTextLabel.textColor = .white
        boldTextLabel.font = UIFont(name: "MarkPro-Bold", size: 25)
        self.addSubview(boldTextLabel)
        boldTextLabel.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(80)
            make.width.equalTo(250)
            make.height.equalTo(33)
        })
    }

    func createSubtitleLabel() {
        subtitleLabel.text = "Enter a username of your choice. Characters should be more than 5."
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont(name: "MarkPro", size: 16)
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(110)
            make.width.equalTo(300)
            make.height.equalTo(44)
        })
    }

    func createLineView() {
        lineView.backgroundColor = . gray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(160)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.height.equalTo(0.3)
        }
    }

    func createUserNameTextField() {
        usernameTextField.placeholder = "Enter Username"
        usernameTextField.lineColor = .white
        usernameTextField.placeHolderColor = .white
        usernameTextField.textColor = .white
        usernameTextField.selectedPlaceHolderColor = .white
        usernameTextField.selectedLineColor = .white
        usernameTextField.errorLineColor = .red
        usernameTextField.font = UIFont(name: "MarkPro", size: 14)
        self.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(250)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    func createErrorLabel(username: String) {
        textFieldErrorLabel.text = "This username, \(username) already exists."
        textFieldErrorLabel.textColor = .red
        textFieldErrorLabel.font = UIFont(name: "MarkPro", size: 12)
        self.addSubview(textFieldErrorLabel)
        textFieldErrorLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(295)
            make.width.equalTo(260)
            make.height.equalTo(44)
        })
    }

    func createUsernameButton() {
        usernameButton.contentMode = .scaleAspectFill
        usernameButton.clipsToBounds = true
        usernameButton.cornerRadius = 25
        usernameButton.backgroundColor = .white
        usernameButton.setTitle("Set Username", for: .normal)
        usernameButton.setTitleColor(.black, for: .normal)
        usernameButton.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        usernameButton.addTarget(self, action: #selector(createUsernameButtonTapped), for: .touchUpInside)
        self.addSubview(usernameButton)
        self.bringSubviewToFront(usernameButton)
        usernameButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(270)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    @objc func createUsernameButtonTapped() {
        delegate?.createUsernameTapped()
    }
}

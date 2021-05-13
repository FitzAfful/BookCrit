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

    let smallLogoView = UIImageView()
    let logoView = UIImageView()
    let bgView = UIImageView()
    let boldTextLabel = UILabel()
    let subtitleLabel = UILabel()
    let googleButton = UIButton()
    let appleButton = UIButton()

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
        createSmallLogoView()
        createLogoView()
        createBoldLabel()
        createSubtitleLabel()
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

    func createLogoView() {
        logoView.image = UIImage(named: "logo_white")
        logoView.contentMode = .scaleAspectFit
        logoView.clipsToBounds = true
        self.addSubview(logoView)
        logoView.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(100)
            make.height.equalTo(242)
            make.width.equalTo(242)
        })
    }

    func createBoldLabel() {
        boldTextLabel.textAlignment = .center
        boldTextLabel.text = "Almost There"
        boldTextLabel.textColor = .white
        boldTextLabel.font = UIFont(name: "MarkPro-Bold", size: 25)
        self.addSubview(boldTextLabel)
        boldTextLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(350)
            make.width.equalTo(164)
            make.height.equalTo(33)
        })
    }

    func createSubtitleLabel() {
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Login now and get started now. Select an option and authorize"
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont(name: "MarkPro", size: 16)
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(385)
            make.width.equalTo(280)
            make.height.equalTo(44)
        })
    }

    func createGoogleButton() {
        googleButton.contentMode = .scaleAspectFill
        googleButton.clipsToBounds = true
        googleButton.layer.cornerRadius = 25
        googleButton.borderColor = .googleBlue
        googleButton.borderWidth = 2
        googleButton.setAttributedTitle(self.createButtonImage(imageType: .google), for: .normal)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        self.addSubview(googleButton)
        self.bringSubviewToFront(googleButton)
        googleButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(150)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    @objc func googleButtonTapped() {
        delegate?.googleButtonTapped()
    }

    func createAppleButton() {
        appleButton.contentMode = .scaleAspectFill
        appleButton.clipsToBounds = true
        appleButton.layer.cornerRadius = 25
        appleButton.backgroundColor = .white
        appleButton.borderWidth = 1
        appleButton.setAttributedTitle(self.createButtonImage(imageType: .apple), for: .normal)
        appleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        self.addSubview(appleButton)
        self.bringSubviewToFront(appleButton)
        appleButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(80)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    @objc func appleButtonTapped() {
        delegate?.appleButtonTapped()
    }

    func createButtonImage(imageType: ImageButton) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString()
        let image1Attachment = NSTextAttachment()
        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 20, height: 20)
        var title: String = "  Login with Apple"
        var color = UIColor.googleBlue
        if imageType == .google {
            image1Attachment.image = UIImage(named: "googleLogo.png")
            title = "  Login with Google"
        } else {
            image1Attachment.image = UIImage(named: "appleLogo.png")
            color = .black
        }
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(title.formatAsAttributed(font: .bold(size: 16), color: color))

        return fullString
    }
}
enum ImageButton {
    case google
    case apple
}

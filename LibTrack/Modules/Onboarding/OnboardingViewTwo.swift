//
//  OnboardingViewTwo.swift
//  LibTrack
//
//  Created by Hosny Savage on 28/02/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardingViewTwoDelegate: class {
    func nextButtonTapped()
    func skipButtonTapped()
}

class OnboardingViewTwo: UIView {
    let onboardingImage = UIImageView()
    let boldTextLabel = UILabel()
    let subtitleLabel = UILabel()

    weak var delegate: OnboardingViewTwoDelegate?
    var loginView: LoginView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: OnboardingViewTwoDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createViews() {
        createOnboardingView()
        createBoldLabel()
        createSubtitleLabel()
    }

    func createOnboardingView() {
        onboardingImage.image = UIImage(named: "onboarding1")
        onboardingImage.contentMode = .scaleAspectFit
        onboardingImage.clipsToBounds = true
        self.addSubview(onboardingImage)
        onboardingImage.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(100)
            make.height.equalTo(242)
            make.width.equalTo(242)
        })
    }

    func createBoldLabel() {
        boldTextLabel.textAlignment = .center
        boldTextLabel.text = "Search & Show Inspire"
        boldTextLabel.lineBreakMode = .byWordWrapping
        boldTextLabel.numberOfLines = 2
        boldTextLabel.textColor = .white
        boldTextLabel.font = UIFont(name: "MarkPro-Bold", size: 25)
        self.addSubview(boldTextLabel)
        boldTextLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(310)
            make.width.equalTo(307)
            make.height.equalTo(100)
        })
    }

    func createSubtitleLabel() {
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Libtrack allows you to search for books using text or QR or Barcode, log/track their read books, find newly released, popular, and bestselling books using ratings and reviews and a recommendation system."
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 5
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont(name: "MarkPro", size: 14)
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(385)
            make.width.equalTo(300)
            make.height.equalTo(130)
        })
    }
}

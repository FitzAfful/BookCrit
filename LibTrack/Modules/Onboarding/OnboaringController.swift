//
//  OnboaringController.swift
//  LibTrack
//
//  Created by Hosny Savage on 27/02/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit

class OnboaringController: BaseViewController, OnboardingViewDelegate {
    func nextButtonTapped() {

    }

    func skipButtonTapped() {

    }

    var onboardingView: OnboardingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }
    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        onboardingView = OnboardingView(delegate: self)
        view.backgroundColor = UIColor(hex: "#000000")
        if let onboarding = onboardingView {
            self.view.addSubview(onboarding)
            onboarding.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }

}

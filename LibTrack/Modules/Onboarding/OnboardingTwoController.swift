//
//  OnboardingTwoController.swift
//  LibTrack
//
//  Created by Hosny Savage on 28/02/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit

class OnboardingTwoController: UIViewController, OnboardingViewTwoDelegate {
    func nextButtonTapped() {

    }

    func skipButtonTapped() {

    }

    var onboardingViewTwo: OnboardingViewTwo?
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        onboardingViewTwo = OnboardingViewTwo(delegate: self)
        view.backgroundColor = UIColor(hex: "#000000")
        if let onboardingTwo = onboardingViewTwo {
            self.view.addSubview(onboardingTwo)
            onboardingTwo.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }
}

//
//  GenreSelectionView.swift
//  LibTrack
//
//  Created by Hosny Savage on 01/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import HTagView

protocol GenreSelectionViewDelegate: class {
    func clearAllButtonTapped()
}

class GenreSelectionView: UIView, HTagViewDelegate {
    let smallLogoView = UIImageView()
    let onboardingImage = UIImageView()
    let boldTextLabel = UILabel()
    let subtitleLabel = UILabel()
    let lineView = UIView()
    let nextButton = UIButton()
    let clearAllButton = UIButton()
    let tagView = HTagView()

    weak var delegate: GenreSelectionViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: GenreSelectionViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createViews() {
        createSmallLogoView()
        createClearAllButton()
        createBoldLabel()
        createSubtitleLabel()
        createLineView()
        createTagsView()
        createDoneButton()
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

    func createClearAllButton() {
        clearAllButton.clipsToBounds = true
        clearAllButton.setTitle("Clear all", for: .normal)
        clearAllButton.setTitleColor(.gray, for: .normal)
        clearAllButton.titleLabel?.font = UIFont(name: "MarkPro", size: 12)
        clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        self.addSubview(clearAllButton)
        self.bringSubviewToFront(clearAllButton)
        clearAllButton.snp.makeConstraints({ (make) in
            make.topMargin.equalTo(50)
            make.rightMargin.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
    }

    func createBoldLabel() {
        boldTextLabel.textAlignment = .left
        boldTextLabel.text = "Select genres"
        boldTextLabel.textColor = .white
        boldTextLabel.font = UIFont(name: "MarkPro-Bold", size: 25)
        self.addSubview(boldTextLabel)
        boldTextLabel.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(60)
            make.width.equalTo(307)
            make.height.equalTo(80)
        })
    }

    func createSubtitleLabel() {
        subtitleLabel.textAlignment = .left
        subtitleLabel.text = "Choose 5 interests so we can recommend you the right books"
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = UIFont(name: "MarkPro", size: 14)
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(120)
            make.width.equalTo(300)
            make.height.equalTo(40)
        })
    }

    func createLineView() {
        lineView.backgroundColor = . gray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(171)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.height.equalTo(0.3)
        }
    }

    func createTagsView() {
        tagView.multiselect = true
        tagView.marg = 20
        tagView.btwTags = 5
        tagView.btwLines = 20
        tagView.tagElevation = 40
        tagView.tagFont = UIFont(name: "MarkPro", size: 14)!
        tagView.tagMainBackColor = UIColor(hex: "#4285F4")
        tagView.tagMainTextColor = UIColor.white
        tagView.tagSecondBackColor = UIColor(hex: "#1E1E1E", alpha: 1)
        tagView.tagSecondTextColor = UIColor.white
        self.addSubview(tagView)
        tagView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(180)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
            make.height.equalTo(200)
        }
        tagView.reloadData()
    }

    func createDoneButton() {
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 25
        nextButton.backgroundColor = .white
        nextButton.setTitle("Done", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        self.addSubview(nextButton)
        self.bringSubviewToFront(nextButton)
        nextButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottom).inset(80)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    @objc func clearAllButtonTapped() {
        self.delegate?.clearAllButtonTapped()
    }

}

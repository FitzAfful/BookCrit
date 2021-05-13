//
//  PageViewController.swift
//  LibTrack
//
//  Created by Hosny Savage on 28/02/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit
import SnapKit

class PageViewController: BasePageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let smallLogoView = UIImageView()
    let nextButton = UIButton()
    let skipButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        createSmallLogoView()
        createPageControl()
        createNextButton()
        createSkipButton()
    }

    func createSmallLogoView() {
        smallLogoView.image = UIImage(named: "logo")
        smallLogoView.contentMode = .scaleAspectFit
        smallLogoView.clipsToBounds = true
        smallLogoView.cornerRadius = 5
        self.view.addSubview(smallLogoView)
        smallLogoView.snp.makeConstraints({ (make) in
            make.topMargin.equalTo(35)
            make.leftMargin.equalTo(15)
            make.height.equalTo(40)
            make.width.equalTo(40)
        })
    }

    func  createPageControl() {
        let initialPage = 0
        let page1 = OnboaringController()
        let page2 = OnboardingTwoController()
        self.pages.append(page1)
        self.pages.append(page2)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        self.view.bringSubviewToFront(self.pageControl)
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -125).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    func createNextButton() {
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 25
        nextButton.backgroundColor = .white
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        self.view.addSubview(nextButton)
        self.view.bringSubviewToFront(nextButton)
        nextButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.view.snp.bottom).inset(70)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    func createSkipButton() {
        skipButton.clipsToBounds = true
        skipButton.layer.cornerRadius = 25
        skipButton.setTitleColor(.gray, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "MarkPro", size: 16)
        skipButton.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        self.view.addSubview(skipButton)
        self.view.bringSubviewToFront(skipButton)
        skipButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(self.view.snp.bottom).inset(20)
            make.width.equalTo(250)
            make.height.equalTo(50)
        })
    }

    @objc func skipButtonAction() {
        if let navigationControl = navigationController as? AuthNavigationController {
            navigationControl.navigate(.login)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

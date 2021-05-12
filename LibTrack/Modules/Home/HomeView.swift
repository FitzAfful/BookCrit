//
//  HomeViewModel.swift
//  LibTrack
//
//  Created by Hosny Savage on 17/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol HomeViewDelegate: class {

}

class HomeView: UIView {

    let boldTextLabel = UILabel()
    let searchBar = UISearchBar()
    let tableView = UITableView()

    weak var delegate: HomeViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: HomeViewDelegate?) {
        self.init(frame: CGRect())
        self.delegate = delegate
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        createHomeLabel()
        createSearchBar()
        createTableView()
    }

    func createHomeLabel() {
        boldTextLabel.text = "Home"
        boldTextLabel.textColor = .white
        boldTextLabel.font = UIFont(name: "MarkPro-Bold", size: 25)
        self.addSubview(boldTextLabel)
        boldTextLabel.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(33)
        })
    }

    func createSearchBar() {
        searchBar.isTranslucent = false
        searchBar.placeholder = "search authors, titles, genres"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MarkPro", size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.tintColor = .gray
        searchBar.barTintColor = .black
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints({ (make) in
            make.leftMargin.equalTo(35)
            make.topMargin.equalTo(75)
            make.width.equalTo(300)
            make.height.equalTo(70)
        })
    }

    func createTableView() {
        tableView.backgroundColor = .white
        tableView.register(UINib(nibName: HomeBookCell.identifier, bundle: nil), forCellReuseIdentifier: HomeBookCell.identifier)
        tableView.register(UINib(nibName: HomeReviewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeReviewCell.identifier)
        self.addSubview(tableView)
        tableView.snp.makeConstraints({ (make) in
            make.topMargin.equalTo(140)
            make.bottom.left.right.equalToSuperview()
        })
    }

    func setTableViewDataSourceDelegate <Obj: UITableViewDataSource & UITableViewDelegate> (
            dataSourceDelegate: Obj) {
            tableView.dataSource = dataSourceDelegate
            tableView.delegate = dataSourceDelegate
            tableView.reloadData()
        }
    
}

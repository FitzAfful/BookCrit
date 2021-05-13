//
//  HomeController.swift
//  LibTrack
//
//  Created by Hosny Savage on 17/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit

class HomeController: BaseViewController, HomeViewDelegate, UISearchBarDelegate/*, UITableViewDelegate, UITableViewDataSource*/ {

    var homeView: HomeView?
    var homeBookCell: HomeBookCell?
    var homeReviewCell: HomeReviewCell?
    let cell = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        homeView = HomeView(delegate: self)
        view.backgroundColor = UIColor(hex: "#000000")
        if let home = homeView {
            self.view.addSubview(home)
            home.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            home.searchBar.delegate = self
//            home.setTableViewDataSourceDelegate(dataSourceDelegate: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: HomeBookCell = tableView.dequeueReusableCell(withIdentifier: HomeBookCell.identifier, for: indexPath) as! HomeBookCell
//
//        return cell
//    }
}

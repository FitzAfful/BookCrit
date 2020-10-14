//
//  SearchController.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: SearchViewModel = SearchViewModel(fetcher: GoogleBooksAPIManager())

    var latestWord = ""
    let searchController = UISearchController(searchResultsController: nil)
    func updateSearchResults(for searchController: UISearchController) {}

    override func viewDidLoad() {
        super.viewDidLoad()

        loader.isHidden = true

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self

        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.isHidden = true

        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("SearchBar text: \(searchText)")
        if !searchText.isEmpty {
            if searchText.count >= 4 {
                //self.search(word: searchText)
            }
        }
    }

    func search(word: String) {
        latestWord = word
        self.tableView.isHidden = false
        loader.isHidden = false
        loader.startAnimating()

        viewModel.searchBook(word: word) { (_, errorMessage, searchedWord) in
            if let error = errorMessage {
                self.showAlert(withTitle: "Error", message: error)
                return
            }

            if self.latestWord == searchedWord {
                self.loader.isHidden = true
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search(word: searchBar.text!)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("isSearching: \(searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true))")
    }

    func initializeFromStoryboard() -> SearchController {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SearchController.storyboardID)
        guard let myController = controller as? SearchController else { fatalError() }
        return myController
    }
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.books.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCell = self.tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.setItem(item: self.viewModel.books[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //To Book Details
    }
}

//
//  HomeBookCell.swift
//  LibTrack
//
//  Created by Hosny Savage on 18/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit

class HomeBookCell: UITableViewCell, UICollectionViewDelegate {

    @IBOutlet weak var rowTitleLabel: UILabel!
    @IBOutlet weak var homeBookCollectionView: UICollectionView!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    
    static let identifier = "HomeBookCell"
    
    var bookCategory: BookCategoryModel?
    var controller: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        homeBookCollectionView.delegate = self
    }
    
    func initialize(section: BookCategoryModel, controller: UIViewController) {
        self.controller = controller
        self.bookCategory = section
        self.rowTitleLabel.text = section.bookSection
        self.bookAuthorLabel.text = "\(section.bookTitle), \(section.bookAuthor)"
        homeBookCollectionView.register(UINib(nibName: "BookCVCell", bundle: nil), forCellWithReuseIdentifier: "BookCVCell")
        homeBookCollectionView.delegate = self
        homeBookCollectionView.dataSource = self
        homeBookCollectionView.showsHorizontalScrollIndicator = false
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width/2 - 10, height: 120)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        homeBookCollectionView.reloadData()
        homeBookCollectionView.collectionViewLayout = flowLayout
    }
    
    func initialize(section: BookCategoryModel) {
        self.bookCategory = section
        self.rowTitleLabel.text = section.bookSection
        self.bookAuthorLabel.text = "\(section.bookTitle), \(section.bookAuthor)"
        homeBookCollectionView.register(UINib(nibName: "BookCVCell", bundle: nil), forCellWithReuseIdentifier: "BookCVCell")
        homeBookCollectionView.delegate = self
        homeBookCollectionView.dataSource = self
        homeBookCollectionView.showsHorizontalScrollIndicator = false
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width/2 - 10, height: 120)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        homeBookCollectionView.reloadData()
        homeBookCollectionView.collectionViewLayout = flowLayout
    }
    
}

extension HomeBookCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let bookCategory = self.bookCategory {
            return bookCategory.bookTitle.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBookCell", for: indexPath) as! HomeBookCell
        
    }
    
    
}

//
//  GenreSelectionController.swift
//  LibTrack
//
//  Created by Hosny Savage on 01/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import UIKit
import HTagView
import SnapKit

class GenreSelectionController: BaseViewController, HTagViewDelegate, HTagViewDataSource {

    var tagData = ["Fiction", "Action", "Adventure", "Classics", "Graphic Novel", "Mystery", "Detective", "Fantasy", "Historical Fiction", "Horror", "Literary Fiction", "Romance", "Science Fiction", "Short Stories", "Suspense", "Thriller", "Women's Fiction", "Biography"]
    var selectedTagData: [Int] = []

    var genreSelectionView: GenreSelectionView?
    var genreViewModel: GenreSelectionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        genreViewModel!.getGenres()
        
    }

    func createViews() {
        self.navigationController?.navigationBar.isHidden = true
        genreSelectionView = GenreSelectionView(delegate: self)
        genreSelectionView?.tagView.delegate = self
        genreSelectionView?.tagView.dataSource = self
        view.backgroundColor = UIColor(hex: "#000000")
        if let genre = genreSelectionView {
            self.view.addSubview(genre)
            genre.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }

    func numberOfTags(_ tagView: HTagView) -> Int {
        return tagData.count
    }

    func tagView(_ tagView: HTagView, tagTypeAtIndex index: Int) -> HTagType {
        return .select
    }

    func tagView(_ tagView: HTagView, titleOfTagAtIndex index: Int) -> NSMutableAttributedString {
        if (selectedTagData.contains(index)) {
            let fullString = NSMutableAttributedString()
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "check.png")
            image1Attachment.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(NSAttributedString(string: tagData[index]))
            print("full: \(fullString)")
            return fullString
        }
        return NSMutableAttributedString(string: tagData[index])
    }

    func tagView(_ tagView: HTagView, tagWidthAtIndex index: Int) -> CGFloat {
        return .HTagAutoWidth
    }

    func tagView(_ tagView: HTagView, tagSelectionDidChange selectedIndices: [Int]) {
        print("tag with indices \(selectedIndices) are selected")
        self.selectedTagData = selectedIndices
        genreSelectionView!.tagView.reloadData()
    }

    func tagView(_ tagView: HTagView, didCancelTagAtIndex index: Int) {
        genreSelectionView!.tagView.reloadData()
    }
    
    func moveToHomeController() {
        
    }

}

extension GenreSelectionController: GenreSelectionViewDelegate {

    func clearAllButtonTapped() {
        for item in genreSelectionView!.tagView.selectedIndices {
            genreSelectionView?.tagView.deselectTagAtIndex(item)
        }
        selectedTagData.removeAll()
        genreSelectionView?.tagView.reloadData()
    }
}

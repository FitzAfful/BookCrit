//
//  SearchCell.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setItem(item: Book) {
        searchImageView.setImage(item.imageUrl!)
        searchLabel.text = item.title + "\n" + item.authors.joined()
    }
}

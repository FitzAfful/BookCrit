//
//  SearchCell.swift
//  LibTrack
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
        let regularFont = UIFont.regular(size: 13)
        let bold = UIFont.bold(size: 16)
        let title = item.title.formatAsAttributed(font: bold, color: UIColor.black)
        let reference = " By \(item.authors.joined(separator: ", "))".formatAsAttributed(font: regularFont, color: UIColor.darkGray)
        let result = NSMutableAttributedString()
        result.append(title)
        result.append(reference)
        self.searchLabel.attributedText = result
        searchImageView.setImage(item.imageUrl!)
    }
}

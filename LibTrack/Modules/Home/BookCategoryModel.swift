//
//  BookCategoryModel.swift
//  LibTrack
//
//  Created by Hosny Savage on 19/03/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation

class BookCategoryModel {
    
    static func == (lhs: BookCategoryModel, rhs: BookCategoryModel) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    var id: Int = 0
    var bookTitle: String = ""
    var bookAuthor: String = ""
    var bookSynopsis: String = ""
    var bookCoverArt: String = ""
    var bookSection: String = ""
}

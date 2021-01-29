//
//  BookHelper.swift
//  LibTrack
//
//  Created by Hosny Savage on 26/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation

class BookHelper {
    func convertBookItemToGoogleItem(bookItem: Book) -> GoogleBookItem {
            var identifiers: [GoogleBookItemVolumeIndustryIdentifier] = []
        if let bn10 = bookItem.isbn {
                    identifiers.append(GoogleBookItemVolumeIndustryIdentifier(type: "ISBN_10", identifier: bn10))
                }
        if let bn13 = bookItem.isbn13 {
                    identifiers.append(GoogleBookItemVolumeIndustryIdentifier(type: "ISBN_13", identifier: bn13))
                }
        let googleBookItemVolume: GoogleBookItemVolume = GoogleBookItemVolume(title: bookItem.title, authors: bookItem.authors, publisher: nil, publishedDate: bookItem.publishedDate, description: bookItem.details, subtitle: nil, pageCount: nil, printType: nil, categories: bookItem.categories)
        return GoogleBookItem(id: bookItem.id, kind: "", etag: "etag", selfLink: "", volumeInfo: googleBookItemVolume)
    }
    func convertGoogleItemToBookItem(googleItem: GoogleBookItem) -> Book {
        let title = googleItem.volumeInfo.title
        let authors = googleItem.volumeInfo.authors
        let publishedDate = googleItem.volumeInfo.publishedDate
        return Book(id: googleItem.id, title: title, authors: authors ?? [], details: (googleItem.volumeInfo.description ?? googleItem.volumeInfo.subtitle) ?? "", categories: googleItem.volumeInfo.categories ?? [], publishedDate: publishedDate, imageUrl: googleItem.volumeInfo.imageLinks?.thumbnail)
    }
}

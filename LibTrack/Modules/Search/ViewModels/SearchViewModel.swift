//
//  SearchViewModel.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation

class SearchViewModel {

    var dataFetcher: GoogleBooksDataFetcher?
    var books: [Book] = []
    var bookHelper: BookHelper = BookHelper()

    init(fetcher: GoogleBooksDataFetcher) {
        self.dataFetcher = fetcher
    }

    func searchBook(word: String, completion: @escaping ([Book]?, String?, String) -> Void) {
        dataFetcher?.searchBookOnGoogleBooks(book: word, completion: { (result) in
            switch result.result {
            case.success(let response):
                self.books = response.items.map({ return self.bookHelper.convertGoogleItemToBookItem(googleItem: $0) })
                completion(self.books, nil, word)
            case .failure:
                completion(nil, BaseNetworkManager().getErrorMessage(response: result), word)
            }
        })
    }

}

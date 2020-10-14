//
//  GoogleBooksAPIManager.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import Alamofire

protocol GoogleBooksDataFetcher {
    func searchBookOnGoogleBooks(book: String, completion:@escaping (DataResponse<GoogleBooksResponse, AFError>) -> Void)
}

public class GoogleBooksAPIManager: GoogleBooksDataFetcher {

    private let manager: Session

    init(manager: Session = Session.default) {
        self.manager = manager
    }

    func searchBookOnGoogleBooks(book: String, completion: @escaping (DataResponse<GoogleBooksResponse, AFError>) -> Void) {
        manager.request(GoogleBooksRouter.searchBookOnGoogleBooks(book: book)).responseDecodable { (response: DataResponse<GoogleBooksResponse, AFError>) in
            print(response)
            completion(response)
        }
    }

}

public class MockGoogleBooksDataFetcher: GoogleBooksDataFetcher {
    func searchBookOnGoogleBooks(book: String, completion: @escaping (DataResponse<GoogleBooksResponse, AFError>) -> Void) {
        let books = GoogleBooksResponse(totalItems: 0, kind: "books", items: [])
        let result = Result<GoogleBooksResponse, AFError>.success(books)
        let response = DataResponse<GoogleBooksResponse, AFError>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        completion(response)
    }

}

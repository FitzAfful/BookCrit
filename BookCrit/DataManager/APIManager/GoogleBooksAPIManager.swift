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
    func getEbooks(completion:@escaping (DataResponse<EbooksResponse, AFError>) -> Void)

}

public class GoogleBooksAPIManager: GoogleBooksDataFetcher {

    private let manager: Session

    init(manager: Session = Session.default) {
        self.manager = manager
    }

    /* func getEbooks(completion:@escaping (DataResponse<EbooksResponse, AFError>) -> Void) {
        manager.request(APIRouter.getEbooks).responseDecodable { (response: DataResponse<EbooksResponse, AFError>) in
            print(response)
            completion(response)
        }
    } */
}

public class MockGoogleBooksDataFetcher: GoogleBooksDataFetcher {
    /*func getDiscover(completion: @escaping (DataResponse<LibraryResponse, AFError>) -> Void) {
        let object = LibraryResponseObject(ebooks: ebookData, audioBooks: audiobookData, teachings: teachingsData, music: musicData, podcasts: podcastData)
        let libraryResponse = LibraryResponse(data: object)
        let result = Result<LibraryResponse, AFError>.success(libraryResponse)
        let response = DataResponse<LibraryResponse, AFError>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        completion(response)
    }*/

}

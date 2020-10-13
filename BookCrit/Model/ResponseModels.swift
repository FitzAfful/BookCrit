//
//  ResponseModels.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation


public struct GoogleBooksResponse: Codable {
    var totalItems: Int
    var kind: String
    var items: [GoogleBookItem]
}

public struct GoogleBookItem: Codable {
    var id: String
    var kind: String
    var etag: String
    var selfLink: String
    var volumeInfo: GoogleBookItemVolume

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case kind = "kind"
        case etag = "etag"
        case selfLink = "selfLink"
        case volumeInfo = "volumeInfo"
    }
}

public struct GoogleBookItemVolume: Codable {
    var title: String
    var authors: [String]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case authors = "authors"
    }
}

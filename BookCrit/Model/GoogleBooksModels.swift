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
        case id
        case kind
        case etag
        case selfLink
        case volumeInfo
    }

    func getBook() -> Book {
        return Book(id: id, title: volumeInfo.title, authors: volumeInfo.authors ?? [], details: (volumeInfo.description ?? volumeInfo.subtitle) ?? "" , categories: volumeInfo.categories ?? [], publishedDate: volumeInfo.publishedDate, imageUrl: volumeInfo.imageLinks?.thumbnail)
    }
}

public struct GoogleBookItemVolume: Codable {
    var title: String
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var subtitle: String?
    var pageCount: Int?
    var printType: String?
    var categories: [String]?
    var averageRating: Double?
    var ratingsCount: Int?
    var contentVersion: String?
    var language: String?
    var infoLink: String?
    var canonicalVolumeLink: String?
    var industryIdentifiers: [GoogleBookItemVolumeIndustryIdentifier]?
    var dimensions: GoogleBookItemVolumeDimensions?
    var imageLinks: GoogleBookItemVolumeImageLinks?
    var saleInfo: GoogleBookItemVolumeSaleInfo?
    var accessInfo: GoogleBookItemVolumeAccessInfo?

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case publisher
        case publishedDate
        case description
        case subtitle
        case pageCount
        case printType
        case categories
        case averageRating
        case ratingsCount
        case contentVersion
        case language
        case infoLink
        case canonicalVolumeLink
        case industryIdentifiers
        case dimensions
        case imageLinks
        case saleInfo
        case accessInfo
    }
}

public struct GoogleBookItemVolumeIndustryIdentifier: Codable {
    var type: String
    var identifier: String
}

public struct GoogleBookItemVolumeDimensions: Codable {
    var height: String
    var width: String
    var thickness: String
}

public struct GoogleBookItemVolumeImageLinks: Codable {
    var smallThumbnail: String
    var thumbnail: String
    var small: String?
    var medium: String?
    var large: String?
    var extraLarge: String?
}

public struct GoogleBookItemVolumeSaleInfo: Codable {
    var country: String
    var saleability: String
    var isEbook: Bool
    var buyLink: String?
    var listPrice: GoogleBookItemVolumeSaleInfoPrice?
    var retailPrice: GoogleBookItemVolumeSaleInfoPrice?
}

public struct GoogleBookItemVolumeSaleInfoPrice: Codable {
    var amount: Double
    var currencyCode: String
}

public struct GoogleBookItemVolumeAccessInfo: Codable {
    var country: String
    var viewability: String
    var embeddable: Bool
    var publicDomain: Bool
    var textToSpeechPermission: String
    var accessViewStatus: String
    var epub: GoogleBookItemVolumeAccessInfoFile?
    var pdf: GoogleBookItemVolumeAccessInfoFile?
}

public struct GoogleBookItemVolumeAccessInfoFile: Codable {
    var isAvailable: Bool
    var downloadLink: String?
    var acsTokenLink: String?
}

//
//  BookHelper.swift
//  LibTrackTests
//
//  Created by Hosny Savage on 26/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import XCTest

class BookHelperTests: XCTestCase {
    
    var bookHelper : BookHelper = BookHelper()
    
    func testConvertBookItemToGoogleItemSuccess() {
        let bookItem = Book(id: "1", title: "Sapiens", authors: ["Yuri"], details: "", categories: ["history"], publishedDate: "", imageUrl: "")
        
       let convertedBookItem = bookHelper.convertBookItemToGoogleItem(bookItem: bookItem)
        
        XCTAssertEqual(convertedBookItem.volumeInfo.title, "Sapiens")
        XCTAssertEqual(convertedBookItem.volumeInfo.authors, ["Yuri"])
        
        
        XCTAssertNotEqual(convertedBookItem.volumeInfo.title, "Blinkards")
        XCTAssertNotEqual(convertedBookItem.volumeInfo.authors, ["Ama Atta Aidoo"])
    }

    
    func testConvertGoogleBookItemToBookItem() {
        let googleBookItemVolume = GoogleBookItemVolume(title: "Sapiens", authors: ["Yuri"], publisher: "", publishedDate: "", description: "", subtitle: "", pageCount: 0, printType: "", categories: [""], averageRating: 2.5, ratingsCount: 0, contentVersion: "", language: "", infoLink: "", canonicalVolumeLink: "", industryIdentifiers: [GoogleBookItemVolumeIndustryIdentifier(type: "", identifier: "")], dimensions: GoogleBookItemVolumeDimensions(height: "", width: "", thickness: ""), imageLinks: GoogleBookItemVolumeImageLinks(smallThumbnail: "", thumbnail: "", small: "", medium: "", large: "", extraLarge: ""), saleInfo: GoogleBookItemVolumeSaleInfo(country: "", saleability: "", isEbook: true, buyLink: "", listPrice: GoogleBookItemVolumeSaleInfoPrice(amount: 10.0, currencyCode: "GHS"), retailPrice: GoogleBookItemVolumeSaleInfoPrice(amount: 10.0, currencyCode: "")), accessInfo: GoogleBookItemVolumeAccessInfo(country: "", viewability: "", embeddable: true, publicDomain: false, textToSpeechPermission: "", accessViewStatus: "", epub: GoogleBookItemVolumeAccessInfoFile(isAvailable: true, downloadLink: "", acsTokenLink: ""), pdf: GoogleBookItemVolumeAccessInfoFile(isAvailable: true, downloadLink: "", acsTokenLink: "")))
        
        let googleBookItem = GoogleBookItem(id: "3", kind: "", etag: "", selfLink: "", volumeInfo: googleBookItemVolume)
        
        let googleConvertedBook = bookHelper.convertGoogleItemToBookItem(googleItem: googleBookItem)
        
        XCTAssertEqual(googleConvertedBook.title, "Sapiens")
        XCTAssertEqual(googleConvertedBook.authors, ["Yuri"])
        
        XCTAssertNotEqual(googleConvertedBook.title, "The God's Must Be Crazy")
        XCTAssertNotEqual(googleConvertedBook.authors, ["Fitz"])
    }
    
}

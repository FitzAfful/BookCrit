//
//  RequestModels.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation

public struct Book: Codable {
    var id: String
    var title: String
    var authors: [String]
    var details: String
    var categories: [String]
    var publishedDate: String?
    var imageUrl: String?
}

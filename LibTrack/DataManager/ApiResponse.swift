//
//  ApiResponse.swift
//  LibTrack
//
//  Created by Hosny Savage on 27/04/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation

struct SignupResponse: Codable {
    var data: SignupData
}

struct SignupData: Codable {
    var username: String?
    var id: String?
    var fullname: String?
    var avatar: String?
    var platform: String?
    var uid: String?
    var genres: [GenresResponse]
}



struct GenresResponse: Codable {
    var id: String?
    var name: String?
}

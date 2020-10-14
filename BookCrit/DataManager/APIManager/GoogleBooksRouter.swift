//
//  GoogleBooksRouter.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import Alamofire

enum GoogleBooksRouter: APIConfiguration {

    case searchBookOnGoogleBooks(book: String)
    case getBookDetails(volumeId: String)

    internal var method: HTTPMethod {
        switch self {
        case .searchBookOnGoogleBooks: return .get
        case .getBookDetails: return .get
        }
    }

    internal var path: String {
        switch self {
        case .searchBookOnGoogleBooks: return NetworkingConstants.googleBooksBaseUrl + "/volumes"
        case .getBookDetails(let volumeId): return NetworkingConstants.googleBooksBaseUrl + "/volumes/\(volumeId)"
        }
    }

    internal var parameters: [String: Any] {
        switch self {
        case .searchBookOnGoogleBooks(let book):
            return ["q": book,
                    "orderBy": "relevance",
                    "key": NetworkingConstants.googleBooksKey]
        default:
            return ["key": NetworkingConstants.googleBooksKey]
        }
    }

    internal var body: [String: Any] {
        switch self {
        default: return [:]
        }
    }

    internal var headers: HTTPHeaders {
        switch self {
        default: return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }

    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: path)!
        var queryItems: [URLQueryItem] = []
        for item in parameters {
            queryItems.append(URLQueryItem(name: item.key, value: "\(item.value)"))
        }
        if !(queryItems.isEmpty) {
            urlComponents.queryItems = queryItems
        }
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)

        print("URL: \(url)")
        print(parameters)
        print(body)

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.dictionary

        if !(body.isEmpty) {
            urlRequest = try URLEncoding().encode(urlRequest, with: body)
            let jsonData1 = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlRequest.httpBody = jsonData1
        }
        return urlRequest
    }
}

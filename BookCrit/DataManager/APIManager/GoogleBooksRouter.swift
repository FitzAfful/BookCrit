//
//  GoogleBooksRouter.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {

    case getEbooks

    internal var method: HTTPMethod {
        switch self {
        case .getEbooks: return .get
        case .getMusic: return .get
        case .getPodcasts: return .get
        case .getTeachings: return .get
        case .getSlides: return .get
        case .getAudioBooks: return .get
        case .getAudioBookChapter: return .get
        case .getMusicVolume: return .get
        case .getPodcastSession: return .get
        case .register: return .post
        case .login: return .post
        case .forgotPassword: return .post
        case .getUserProfile: return .get
        case .updateProfile: return .post
        case .changePassword: return .put
        case .changeName: return .put
        case .liveStream: return .get
        }
    }

    internal var path: String {
        switch self {
        case .getEbooks: return NetworkingConstants.baseUrl + "ebooks"
        case .getAudioBooks: return NetworkingConstants.baseUrl + "audiobooks"
        case .getMusic: return NetworkingConstants.baseUrl + "music"
        case .getPodcasts: return NetworkingConstants.baseUrl + "podcasts"
        case .getSlides: return NetworkingConstants.baseUrl + "slides"
        case .getTeachings: return NetworkingConstants.baseUrl + "teachings"
        case .register: return NetworkingConstants.baseUrl + "request-account"
        case .getAudioBookChapter(let audioBookId, let audioBookChapterId): return NetworkingConstants.baseUrl + "audiobooks/\(audioBookId)/\(audioBookChapterId)"
        case .getMusicVolume(let musicId, let musicVolumeId): return NetworkingConstants.baseUrl + "music/\(musicId)/\(musicVolumeId)"
        case .getPodcastSession(let podcastId, let sessionId): return NetworkingConstants.baseUrl + "podcasts/\(podcastId)/\(sessionId)"
        case .login: return NetworkingConstants.baseUrl + "login"
        case .forgotPassword: return NetworkingConstants.baseUrl + "forgot-password"
        case .getUserProfile: return NetworkingConstants.baseUrl
        case .updateProfile: return NetworkingConstants.baseUrl
        case .changePassword(let id, _): return NetworkingConstants.baseUrl + "password-change/\(id)"
        case .changeName(let id, _): return NetworkingConstants.baseUrl + "profile-update/\(id)"
        case .liveStream: return "https://myprophecynow.com/api/v1/live-stream"
        }
    }

    internal var parameters: [String: Any] {
        switch self {
        default: return [:]
        }
    }

    internal var body: [String: Any] {
        switch self {
        case .register(let param):
            return param.dictionary
        case .login(let param):
            return param.dictionary
        case .forgotPassword(let param):
            return ["email": param]
        case .changePassword(_, let param):
            return param.dictionary
        case .changeName(_, let param):
            return param.dictionary
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

//
//  AuthEndpoints.swift
//  RideAlong
//
//  Created by Created by Hosny Ben Savage on 20/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import Alamofire

enum AuthRouter: APIConfiguration {

    case signup
    case chooseUsername(parameter: ChooseUsernameParameter)
    case getGenres
    case getUserGenres(parameter: GetUserGenresParameter)

	internal var method: HTTPMethod {
        switch self {
        case .signup:
            return .post
        case .chooseUsername:
            return .put
        case .getGenres:
            return .get
        case .getUserGenres:
            return .get
        }
	}

	internal var path: String {

        switch self {
        case .signup:
            return NetworkingConstants.signup
        case .chooseUsername(let username):
            return NetworkingConstants().chooseUsername(uid: username.newUsername)
        case .getGenres:
            return NetworkingConstants.getGenre
        case .getUserGenres(let uid):
            return NetworkingConstants().getUserGenres(uid: uid.uid)
        }
	}

    internal var parameters: [String: Any] {
        switch self {
        case .signup:
            return [:]
        case .chooseUsername:
            return [:]
        case .getGenres:
            return [:]
        case .getUserGenres:
            return [:]
        }
    }

	internal var body: [String: Any] {
        switch self {
        case .signup:
            return [:]
        case .chooseUsername(let parameter):
            var param: [String: Any] = [:]
            do {
                let param1 = try DictionaryEncoder().encode(parameter)
                print("Param1: \(param1)")
                param = param1 as! [String: Any]
            } catch {
                print("Couldn't parse parameter")
            }
            return param
        case .getGenres:
            return [:]
        case .getUserGenres(let parameter):
            var param: [String: Any] = [:]
            do {
                let param1 = try DictionaryEncoder().encode(parameter)
                print("Param1: \(param1)")
                param = param1 as! [String: Any]
            } catch {
                print("Couldn't parse parameter")
            }
            return param
        }
    }

	internal var headers: HTTPHeaders {
        switch self {

        default:
            let api_token = UserDefaults.standard.string(forKey: "idToken")
            if (api_token != nil) {
                return ["idToken": "\(api_token!)","Content-Type":"application/json", "Accept": "application/json"]
            }
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
	}

    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: NetworkingConstants.baseUrlEndpoint + path)!
        var queryItems: [URLQueryItem] = []
        for item in parameters {
            queryItems.append(URLQueryItem(name: item.key, value: "\(item.value)"))
        }
        if(!(queryItems.isEmpty)) {
            urlComponents.queryItems = queryItems
            print("Query Items: \(queryItems)")
            print(parameters)
        }
        let url = urlComponents.url!
        print("Full URL: \(url)")
        print("headers: \(headers.dictionary)")
        print("body: \(body)")
        print(path)
        print("parameters: \(parameters)")

        var urlRequest = URLRequest(url: url)

        var jsonData1: Data! = nil

        switch self {

        default:
            jsonData1 = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.dictionary
        if(!body.isEmpty) {
            urlRequest.httpBody = jsonData1
            //                    let show =  try URLEncoding.methodDependent.encode(urlRequest, with: body)
            print("body: \(jsonData1)")
        }

        return urlRequest
    }
}

// ************************************** AUTH MANAGER PARAMETERS **********************************************//

struct ChooseUsernameParameter: Codable {
    var newUsername: String
}

struct GetUserGenresParameter: Codable {
    var uid: String
}

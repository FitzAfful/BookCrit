//
//  AuthNetworkManager.swift
//  RideAlong
//
//  Created by Hosny Ben Savage on 20/01/2019.
//  Copyright © 2020 IT Consortium. All rights reserved.
//

import Foundation
import Alamofire

class AuthNetworkManager: NetworkManager {

    static func signUp(completion: @escaping (DataResponse<SignupResponse, AFError>) -> Void) {
        AF.request(AuthRouter.signup)
            .responseDecodable { (response: DataResponse<SignupResponse, AFError>) in
                print(response)
                print("response code: \(String(describing: response.response?.statusCode))")

                completion(response)
        }
    }

    static func chooseUsername(parameter: ChooseUsernameParameter, completion: @escaping (DataResponse<SignupResponse, AFError>) -> Void) {
        AF.request(AuthRouter.chooseUsername(parameter: parameter))
            .responseDecodable { (response: DataResponse<SignupResponse, AFError>) in
                print(response)
                print("response code: \(String(describing: response.response?.statusCode))")

                completion(response)
        }
    }

    static func getGenres(completion: @escaping (DataResponse<GenresResponse, AFError>) -> Void) {
        AF.request(AuthRouter.getGenres)
            .responseDecodable { (response: DataResponse<GenresResponse, AFError>) in
                print(response)
                print("response code: \(String(describing: response.response?.statusCode))")

                completion(response)
        }
    }

    static func getUserGenres(parameter: GetUserGenresParameter, completion: @escaping (DataResponse<GenresResponse, AFError>) -> Void) {
        AF.request(AuthRouter.getUserGenres(parameter: parameter))
            .responseDecodable { (response: DataResponse<GenresResponse, AFError>) in
                print(response)
                print("response code: \(String(describing: response.response?.statusCode))")

                completion(response)
        }
    }
}

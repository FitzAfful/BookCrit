//
//  BaseNetworkManager.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 13/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import Alamofire

public class BaseNetworkManager {

    public func getErrorMessage<T>(response: DataResponse<T, AFError>) -> String where T: Codable {
        var message = NetworkingConstants.networkErrorMessage
        if let data = response.data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let error = json["errors"] as? NSDictionary {
                    message = error["message"] as! String
                } else if let error = json["error"] as? NSDictionary {
                    if let message1 = error["message"] as? String {
                        message = message1
                    }
                } else if let messages = json["message"] as? String {
                    message = messages
                } else if let messages = json["error"] as? String {
                    message = messages
                }
            }
        }
        return message
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        var param: [String: Any] = [: ]
        do {
            let param1 = try DictionaryEncoder().encode(self)
            param = param1 as! [String: Any]
        } catch {
            print("Couldnt parse parameter")
        }
        return param
    }
}

//
//  CreateUsernameViewModel.swift
//  LibTrack
//
//  Created by Hosny Savage on 11/05/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import Alamofire

class CreateUsernameViewModel {
    var genres: [GenresResponse] = []
    var view: CreateUsernameController

    init(view: CreateUsernameController) {
        self.view = view
    }
    

    func chooseUsername(chooseUsernameParameter: ChooseUsernameParameter) {
        AuthNetworkManager.chooseUsername(parameter: chooseUsernameParameter) { (result) in
            self.parseChooseUsernameResponse(result: result)
        }
    }
    
    private func parseChooseUsernameResponse(result: DataResponse<SignupResponse, AFError>) {
        switch result.result {
        case .success(let response):
            print(response)
            for item in response.data.genres {
                genres.append(item)
            }
                view.moveToSelectGenreController()
            break
        case .failure( _):
            break

        }
    }
}

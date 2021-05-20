//
//  GenreSelectionViewModel.swift
//  LibTrack
//
//  Created by Hosny Savage on 13/05/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import Alamofire

class GenreSelectionViewModel {

    var view: GenreSelectionController

    init(view: GenreSelectionController) {
        self.view = view
    }
    
    func getGenres() {
        AuthNetworkManager.getGenres { (result) in
            self.parseGetGenresResponse(result: result)
        }
    }

    private func parseGetGenresResponse(result: DataResponse<GenresResponse, AFError>) {
        switch result.result {
        case .success(let response):
            print(response)
            
            view.genreData.append(response)
            break
        case .failure( _):
            break

        }
    }

    func sendUserGenres(getUserGenresParameter: GetUserGenresParameter) {
        AuthNetworkManager.getUserGenres(parameter: getUserGenresParameter) { (result) in
            self.parseUserGenresResponse(result: result)
        }
    }

    private func parseUserGenresResponse(result: DataResponse<GenresResponse, AFError>) {
        switch result.result {
        case .success(let response):
            print(response)
            //do something when you get a user's response
            break
        case .failure( _):
            break

        }
    }
}

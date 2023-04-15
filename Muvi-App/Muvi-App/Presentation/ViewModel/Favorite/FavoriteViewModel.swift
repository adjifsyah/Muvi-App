//
//  FavoriteViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import Foundation

class FavoriteViewModel {
    var favoriteMovie: [MoviesModel]?
    var movieFilter: [MoviesModel]?
    
    var showAlertClosurePopular: ((String) -> ())?
    var updateLoadingStatusPopular: (() -> ())?
    var didFinishFetchPopular: (() -> ())?
    
    func fetchListFavorite() {
        CoreDataManager.shared.retrieve { result in
            switch result {
            case .success(let data):
                self.favoriteMovie = data
                self.didFinishFetchPopular?()
            case .failure(let error):
                self.showAlertClosurePopular?(error.localizedDescription)
            }
        }
    }
}

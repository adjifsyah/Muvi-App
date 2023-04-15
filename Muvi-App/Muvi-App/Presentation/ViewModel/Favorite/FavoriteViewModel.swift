//
//  FavoriteViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import Foundation

class FavoriteViewModel {
    
//    var movieBanner: [MoviesModel]?
//    var moviePopular: [MoviesModel]?
//    var movieComingSoon: [MoviesModel]?
//
//    var showAlertClosurePopular: ((String) -> ())?
//    var updateLoadingStatusPopular: (() -> ())?
//    var didFinishFetchPopular: (() -> ())?
//    
//    func fetchMoviePopular() {
//        AFService.shared.fetchListPopularPage { result in
//            switch result {
//            case .success(let success):
//                let mapper = success.map { MoviesModel(
//                    movieId: $0.movieId ?? 0,
//                    movieTitle: $0.movieTitle ?? "",
//                    overview: $0.overview ?? "",
//                    releaseDate: $0.releaseDate ?? "",
//                    backdropUrlPath: NetworkConstant.shared.imageServerAddress + ($0.backdropUrlPath ?? ""),
//                    posterUrlPath: NetworkConstant.shared.imageServerAddress + ($0.posterUrlPath ?? "")
//                )}
//                self.movieBanner = mapper
//                self.didFinishFetchPopular?()
//            case .failure(let error):
//                self.showAlertClosurePopular?(error.localizedDescription)
//            }
//        }
//    }
}

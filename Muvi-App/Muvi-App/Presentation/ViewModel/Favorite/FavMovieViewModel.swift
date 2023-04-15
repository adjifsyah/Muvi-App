//
//  FavMovieViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 15/04/23.
//

import Foundation

class FavMovieViewModel {
    var detailMovie: [MoviesModel]? {
        didSet {
            movieFilter = detailMovie?.filter { $0.movieTitle != "" }
        }
    }
    
    var movieFilter: [MoviesModel]?
    
    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    func fetchFavoriteMovie(completion: @escaping (Result<[MoviesModel]?, Error>) -> Void) {
        CoreDataManager.shared.retrieve { result in
            switch result {
            case .success(let success):
                let mapper = success.map { MoviesModel(movieId: $0.movieId, movieTitle: $0.movieTitle, overview: $0.overview, releaseDate: $0.releaseDate, backdropUrlPath: $0.posterUrlPath, posterUrlPath: $0.posterUrlPath)}
                self.detailMovie = mapper
                completion(.success(self.detailMovie))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func removeFavorite(byTitle: String, completion: @escaping (Result<String, Error>) -> Void) {
        CoreDataManager.shared.delete(byTitle) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovies(title: String, completion: @escaping () -> Void) {
        movieFilter = detailMovie?.filter{ $0.movieTitle.lowercased().contains(title.lowercased())}
        completion()
    }
}

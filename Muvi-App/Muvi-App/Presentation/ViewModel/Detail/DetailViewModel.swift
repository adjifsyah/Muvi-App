//
//  DetailViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import Foundation

class DetailViewModel {
    var detailMovie: DetailMovies?
    var datasourceCast: [CastModel]?

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var didFinishFetchCast: (() -> ())?
    
    func fetchMoviePopular(movieId: Int) {
        AFService.shared.fetchMovieDetail(input: movieId) { result in
            switch result {
            case .success(let success):
                let mapper = DetailMovies(
                    movieId: success.movieId ?? 0, movieGenres: success.movieGenres?.map { MovieGenres(genreId: $0.genreId ?? 0, genre: $0.genre ?? "")} ?? [],
                    movieTitle: success.movieTitle ?? "",
                    moviePopularity: success.moviePopularity ?? 0,
                    imgUrlPath: NetworkConstant.shared.imageServerAddress + (success.imgUrlPath ?? ""),
                    releaseDate: success.releaseDate ?? "",
                    overview: success.overview ?? "")
                self.detailMovie = mapper
                self.didFinishFetch?()
            case .failure(let error):
                self.showAlertClosure?(error.localizedDescription)
            }
        }
    }
    
    func fetchCredit(by movieId: Int) {
        AFService.shared.fetchCredit(by: movieId) { result in
            switch result {
            case .success(let success):
                let remoteCredit = success.cast?.map { CastModel(id: $0.id ?? 0,
                                                                 departement: $0.departement ?? "",
                                                                 nameCast: $0.nameCast ?? "",
                                                                 imageUrlString: NetworkConstant.shared.imageServerAddress + ($0.imagePath ?? ""))}
                self.datasourceCast = remoteCredit
                self.didFinishFetchCast?()
            case .failure(let error):
                self.showAlertClosure?(error.localizedDescription)
            }
        }
    }
    
    func retriveCoreData(completion: @escaping (Result<[MoviesModel], GeneralError>) -> Void) {
        CoreDataManager.shared.retrieve { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(_):
                completion(.failure(.failGetLocalData))
            }
        }
    }
}

//
//  SearchViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import UIKit

class SearchViewModel {
    var moviePopular: [MoviesModel]? {
        didSet {
            movieFilter = moviePopular
        }
    }
    
    var movieFilter: [MoviesModel]?

    var showAlertClosurePopular: ((String) -> ())?
    var updateLoadingStatusPopular: (() -> ())?
    var didFinishFetchPopular: (() -> ())?
    
    func fetchMoviePopular() {
        AFService.shared.fetchListPopularPage { result in
            switch result {
            case .success(let success):
                let mapper = success.map { MoviesModel(
                    movieId: $0.movieId ?? 0,
                    movieTitle: $0.movieTitle ?? "",
                    overview: $0.overview ?? "",
                    releaseDate: $0.releaseDate ?? "",
                    backdropUrlPath: NetworkConstant.shared.imageServerAddress + ($0.backdropUrlPath ?? ""),
                    posterUrlPath: NetworkConstant.shared.imageServerAddress + ($0.posterUrlPath ?? "")
                )}
                self.moviePopular = mapper.filter( { $0.posterUrlPath.contains("jpg")})
                self.didFinishFetchPopular?()
            case .failure(let error):
                self.showAlertClosurePopular?(error.localizedDescription)
            }
        }
    }
    
    func searchMovies(title: String) {
        AFService.shared.searchMovies(by: title) { result in
            switch result {
            case .success(let success):
                let mapper = success.map { MoviesModel(
                    movieId: $0.movieId ?? 0,
                    movieTitle: $0.movieTitle ?? "",
                    overview: $0.overview ?? "",
                    releaseDate: $0.releaseDate ?? "",
                    backdropUrlPath: NetworkConstant.shared.imageServerAddress + ($0.backdropUrlPath ?? ""),
                    posterUrlPath: NetworkConstant.shared.imageServerAddress + ($0.posterUrlPath ?? ""))}
                self.movieFilter = mapper
                self.didFinishFetchPopular?()
            case .failure(let error):
                self.showAlertClosurePopular?(error.localizedDescription)
            }
        }
    }
    
    func goToDetailView(by id: Int, nav: UINavigationController) {
        let detailView = DetailPageVC()
        detailView.fetchData(by: id)
        nav.pushViewController(detailView, animated: true)
    }
}

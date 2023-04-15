//
//  HomeViewModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import UIKit

class HomeViewModel {
    
    var movieBanner: [MoviesModel]?
    var moviePopular: [MoviesModel]?
    var movieComingSoon: [MoviesModel]?

    var showAlertClosureBanner: ((String) -> ())?
    var showAlertClosurePopular: ((String) -> ())?
    var showAlertClosureComing: ((String) -> ())?
    
    var updateLoadingStatuBanners: (() -> ())?
    var updateLoadingStatusPopular: (() -> ())?
    var updateLoadingStatusComing: (() -> ())?
    
    var didFinishFetchBanner: (() -> ())?
    var didFinishFetchPopular: (() -> ())?
    var didFinishFetchComing: (() -> ())?
    
    func fetchBanner() {
        AFService.shared.fetchListBanner { result in
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
                self.movieBanner = mapper
                self.didFinishFetchBanner?()
            case .failure(let error):
                self.showAlertClosureBanner?(error.localizedDescription)
            }
        }
    }
    
    func fetchPopular() {
        AFService.shared.fetchListPopular { result in
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
                self.moviePopular = mapper
                self.didFinishFetchPopular?()
            case .failure(let error):
                self.showAlertClosurePopular?(error.localizedDescription)
            }
        }
    }
    
    func fetchComingSoon() {
        AFService.shared.fetchListComingSoon { result in
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
                self.movieComingSoon = mapper
                self.didFinishFetchComing?()
            case .failure(let error):
                self.showAlertClosureComing?(error.localizedDescription)
            }
        }
    }
    
    func goToDetailView(by id: Int, nav: UINavigationController) {
        let detailView = DetailPageVC()
        detailView.fetchData(by: id)
        nav.pushViewController(detailView, animated: true)
    }
}

//
//  AFService.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import Foundation
import Alamofire
import ObjectMapper

class AFService {
    static let shared = AFService()
    
    private init() { }
    
    func fetchListBanner(completion: @escaping (Result<[RemoteMoviesModel], Error>) -> Void) {
        guard let url = createURL(input: "/3/discover/movie", params: ["page": "2"]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                let movie = ResponseMovie(JSONString: success)
                
                completion(.success(movie?.listMovies ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchListPopular(completion: @escaping (Result<[RemoteMoviesModel], Error>) -> Void) {
        guard let url = createURL(input: "/3/movie/popular", params: [:]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                let movie = ResponseMovie(JSONString: success)
                completion(.success(movie?.listMovies ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchListComingSoon(completion: @escaping (Result<[RemoteMoviesModel], Error>) -> Void) {
        let year = Calendar.current.component(.year, from: Date())
        
        guard let url = createURL(input: "/3/movie/popular", params: ["year": "\(year + 1)"]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                let movie = ResponseMovie(JSONString: success)
                completion(.success(movie?.listMovies ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchListPopularPage(completion: @escaping (Result<[RemoteMoviesModel], Error>) -> Void) {
        let year = Calendar.current.component(.year, from: Date())
        guard let url = createURL(input: "/3/discover/movie", params: [
            "sort_by": "popularity.desc",
            "year": "\(year + 1)"
        ]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                let movie = ResponseMovie(JSONString: success)
                completion(.success(movie?.listMovies ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // https://api.themoviedb.org/3/movie/520763?api_key=7e6dc9e445f1edd16330cb045b7ba4c0&language=en-US
    func fetchMovieDetail(input movieId: Int, completion: @escaping (Result<ResponseMoviesDetail, Error>) -> Void) {
        guard let url = createURL(input: "/3/movie/\(movieId)", params: [:]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                if let movie = ResponseMoviesDetail(JSONString: success) {
                    completion(.success(movie))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // https://api.themoviedb.org/3/movie/520763/credits?api_key=7e6dc9e445f1edd16330cb045b7ba4c0&language=en-US
    func fetchCredit(by castId: Int, completion: @escaping (Result<ResponseCredit, Error>) -> Void) {
        guard let url = createURL(input: "/3/movie/\(castId)/credits", params: [:]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                if let movie = ResponseCredit(JSONString: success) {
                    completion(.success(movie))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
    func searchMovies(by title: String, completion: @escaping (Result<[RemoteMoviesModel], Error>) -> Void) {
        guard let url = createURL(input: "/3/search/movie", params: ["query": title]) else { return }
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let success):
                if let movie = ResponseMovie(JSONString: success) {
                    completion(.success(movie.listMovies ?? []))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    private func createURL(input path: String, params: [String: String]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = path
        
        var queryItems = [URLQueryItem(name: "api_key", value: NetworkConstant.shared.apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}

// https://api.themoviedb.org/search/movie?api_key=7e6dc9e445f1edd16330cb045b7ba4c0&query=avatar


// https://api.themoviedb.org/3/search/movie?api_key=7e6dc9e445f1edd16330cb045b7ba4c0&language=en-US&query=ninja&page=1&include_adult=false

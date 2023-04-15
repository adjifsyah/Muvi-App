//
//  MovieListModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 12/04/23.
//

import Foundation
import ObjectMapper

class ResponseMovie: Mappable {
    var listMovies: [RemoteMoviesModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        listMovies  <-  map["results"]
    }
    
}

class RemoteMoviesModel: Mappable {
    var movieId: Int?
    var movieTitle: String?
    var overview: String?
    var releaseDate: String?
    var backdropUrlPath: String?
    var posterUrlPath: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        movieId  <-  map["id"]
        movieTitle  <-  map["original_title"]
        overview  <-  map["overview"]
        releaseDate  <-  map["release_date"]
        backdropUrlPath  <-  map["backdrop_path"]
        posterUrlPath  <-  map["poster_path"]
    }

}

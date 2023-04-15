//
//  ResponseMovieDetail.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import Foundation
import ObjectMapper

class ResponseMoviesDetail: Mappable {
    var movieGenres: [RemoteGenres]?
    var movieTitle: String?
    var moviePopularity: Double?
    var imgUrlPath: String?
    var releaseDate: String?
    var overview: String?
    
    required init?(map: Map) { }
    
    func mapping(map: ObjectMapper.Map) {
        movieGenres  <-  map["genres"]
        movieTitle  <-  map["original_title"]
        moviePopularity  <-  map["popularity"]
        imgUrlPath <- map["poster_path"]
        releaseDate  <-  map["release_date"]
        overview  <-  map["overview"]
    }
}

class RemoteGenres: Mappable {
    var genreId: Int?
    var genre: String?
    
    required init?(map: ObjectMapper.Map) { }
    
    func mapping(map: ObjectMapper.Map) {
        genreId <- map["id"]
        genre <- map["name"]
    }
}

struct DetailMovies {
    let movieGenres: [MovieGenres]
    let movieTitle: String
    let moviePopularity: Double
    let imgUrlPath: String
    let releaseDate: String
    let overview: String
}

struct MovieGenres {
    let genreId: Int
    let genre: String
}

/*
 "adult": false,
   "backdrop_path": "/uR952NrgispGuyqIdUbkR24vE0u.jpg",
   "belongs_to_collection": null,
   "budget": 0,
   "genres": [
     {
       "id": 28,
       "name": "Action"
     },
     {
       "id": 878,
       "name": "Science Fiction"
     }
   ],
   "homepage": "https://www.marvel.com/movies/avengers-kang-dynasty",
   "id": 1003596,
   "imdb_id": "tt21357150",
   "original_language": "en",
   "original_title": "Avengers: The Kang Dynasty",
   "overview": "An upcoming film in the Marvel Cinematic Universe's sixth Phase and part of The Multiverse Saga. Plot unknown.",
   "popularity": 39.601,
   "poster_path": "/utZTb3VBrH0zR77BcISU67pHuAx.jpg",
   "production_companies": [
     {
       "id": 420,
       "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
       "name": "Marvel Studios",
       "origin_country": "US"
     },
     {
       "id": 176762,
       "logo_path": null,
       "name": "Kevin Feige Productions",
       "origin_country": "US"
     }
   ],
   "production_countries": [
     {
       "iso_3166_1": "US",
       "name": "United States of America"
     }
   ],
   "release_date": "2025-05-01",
   "revenue": 0,
   "runtime": 0,
   "spoken_languages": [
     {
       "english_name": "English",
       "iso_639_1": "en",
       "name": "English"
     }
   ],
   "status": "Planned",
   "tagline": "",
   "title": "Avengers: The Kang Dynasty",
   "video": false,
   "vote_average": 0,
   "vote_count": 0
 }
 */

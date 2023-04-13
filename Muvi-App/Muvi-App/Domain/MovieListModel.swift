//
//  MovieListModel.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 12/04/23.
//

import Foundation

struct ResponseMovies {
    let listMovies: [RemoteMoviesModel]
}

struct RemoteMoviesModel {
    let movieId: Int
    let movieTitle: String
    let overview: String
    let releaseDate: String
    let backdropUrlPath: String
    let posterUrlPath: String
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case movieTitle = "original_title"
        case movieOverview = "overview"
        case releaseDate = "release_date"
        case backdropUrlPath = "backdrop_path"
        case posterUrlPath = "poster_path"
    }
}
// https://image.tmdb.org/t/p/w500

/*
 "results": [
    {
      "adult": false,
      "backdrop_path": "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
      "genre_ids": [
        16,
        12,
        10751,
        14,
        35
      ],
      "id": 502356,
      "original_language": "en",
      "original_title": "The Super Mario Bros. Movie",
      "overview": "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
      "popularity": 9513.942,
      "poster_path": "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
      "release_date": "2023-04-05",
      "title": "The Super Mario Bros. Movie",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 558
    },
    {
      "adult": false,
      "backdrop_path": "/5i6SjyDbDWqyun8klUuCxrlFbyw.jpg",
      "genre_ids": [
        18,
        28
      ],
      "id": 677179,
      "original_language": "en",
      "original_title": "Creed III",
      "overview": "After dominating the boxing world, Adonis Creed has been thriving in both his career and family life. When a childhood friend and former boxing prodigy, Damien Anderson, resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face-off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damien — a fighter who has nothing to lose.",
      "popularity": 6029.319,
      "poster_path": "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg",
      "release_date": "2023-03-01",
      "title": "Creed III",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 900
    },
 */

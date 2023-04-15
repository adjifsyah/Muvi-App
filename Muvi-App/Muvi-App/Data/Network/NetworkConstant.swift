//
//  NetworkConstant.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 14/04/23.
//

import Foundation

class NetworkConstant {
    static let shared = NetworkConstant()
    private init() { }
    
    var apiKey: String {
        return "7e6dc9e445f1edd16330cb045b7ba4c0"
    }
    
    var serverAddress: String {
        return "https://api.themoviedb.org/3/discover/movie"
    }
    
    var imageServerAddress: String {
        return "https://image.tmdb.org/t/p/w500"
    }
}

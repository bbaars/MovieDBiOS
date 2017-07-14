//
//  Genre.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/10/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire


class Genre {
    
    var chosenGenre: String
    var genreMovies: Movie!
    
    var movieGenre  = [
        "Action": 28,
        "Adventure": 12,
        "Animation": 16,
        "Comdey": 35,
        "Crime": 80,
        "Documentary": 99,
        "Drama": 18,
        "Family": 10751,
        "Fantasty": 14,
        "History": 36,
        "Horror": 27,
        "Music": 10402,
        "Mystery": 9648,
        "Romance": 10749,
        "Science Fiction": 878,
        "TV Movie": 10770,
        "Thriller": 53,
        "War": 10752,
        "Western": 37
    ]
    
    
    init(genre: String) {
        chosenGenre = genre
    }
    
    
    func getGenreId() -> Int {
        
        if let _ = movieGenre[chosenGenre] {
            return movieGenre[chosenGenre]!
        }
        
        return 0
    }
}

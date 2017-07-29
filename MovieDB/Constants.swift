//
//  Constants.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation

/* API Relevent information needed to make a request to TMDB */
let APIKey = "6615c9824f812a6fb9b8b4ea5f49a285"
let APIUrlPrefix = "https://api.themoviedb.org/3"
let imageUrlPrefix = "https://image.tmdb.org/t/p/"
let youtubeVideoUrl = "https://www.youtube.com/watch?v="
let sessionString = "720e0b015cfd60b7ad5ab0f12f448f7b9acd35e6"

public enum DisplayType : Int {
    case poster
    case backdrop
    case profile
}

struct movieKeys {
    
    static let Adult = "adult"
    static let BackdropPath = "backdrop_path"
    static let Budget = "budget"
    static let Cast = "cast"
    static let Genres = "genres"
    static let Homepage = "homepage"
    static let ID = "id"
    static let IMDBID = "imdb_id"
    static let MovieTrailer = "trailer"
    static let OriginalLanguage = "original_language"
    static let OriginalTitle = "original_title"
    static let Overview = "overview"
    static let Popularity = "popularity"
    static let PosterPath = "poster_path"
    static let ReleaseDate = "release_date"
    static let Revenue = "revenue"
    static let Reviews = "reviews"
    static let Runtime = "runtime"
    static let Status = "status"
    static let Tagline = "tagline"
    static let Title = "title"
    static let Video = "video"
    static let VoteAverage = "vote_average"
    static let VoteCount = "vote_count"
}

struct actorKeys {
    
    static let Adult = "adult"
    static let Biography = "biography"
    static let Birthday = "birthday"
    static let Deathday = "deathday"
    static let Gender = "gender"
    static let Homepage = "homepage"
    static let ID = "id"
    static let Movies = "movies"
    static let Name = "name"
    static let PlaceOfBirth = "place_of_birth"
    static let Popularity = "popularity"
    static let ProfilePath = "profile_path"
}

struct reviewKeys {
    static let ID = "id"
    static let Author = "author"
    static let Content = "content"
    static let Url = "url"
}

struct SearchTypes {
    static let popular = "/movie/popular"
}

/* typealia for when an asynchronous function completes */
public typealias DownloadComplete = () -> ()

/* typealia for when an progress during download */
public typealias ProgressHandler = (Progress) -> Void

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

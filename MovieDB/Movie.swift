//
//  Movie.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/8/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation

class Movie {
    
    private var _adult: Bool?
    private var _backdropPath: String?
    private var _budget: String?
    private var _cast: [Cast]?
    private var _character: String?
    private var _genre: [[String:Any]]?
    private var _homepage: String?
    private var _id: Int?
    private var _imdbId: String?
    private var _movieTrailer: String?
    private var _originalLanguage: String?
    private var _originalTitle: String?
    private var _overview: String?
    private var _popularity: Double?
    private var _posterPath: String?
    private var _releaseDate: String?
    private var _revenue: Int?
    private var _reviews: [Review]?
    private var _runtime: Int?
    private var _status: String?
    private var _tagline: String?
    private var _title: String?
    private var _video: Bool?
    private var _voteAverage: Double?
    private var _voteCount: Int?
    
    
    var adult: Bool {
        
        if _adult == nil {
            return false
        }
        
        return _adult!
    }
    
    var backdropPath: String {
        if _backdropPath == nil {
            return ""
        }
        
        return _backdropPath!
    }
    
    var budget: String {
        if _budget == nil {
            return ""
        }
        
        return _budget!
    }
    
    var cast: [Cast] {
        if _cast == nil {
            return []
        }
        
        return _cast!
    }
    
    var character: String {
        if _character == nil {
            return ""
        }
        
        return _character!
    }
    
    var genre: [[String:Any]] {
        if _genre == nil {
            return [["":0]]
        }
        
        return _genre!
    }
    
    var homepage: String {
        if _homepage == nil {
            return ""
        }
        
        return _homepage!
    }
    
    var id: Int {
        if _id == nil {
            return 0
        }
        
        return _id!
    }
    
    var imdbId: String {
        if _imdbId == nil {
            return ""
        }
        
        return _imdbId!
    }
    
    var movieTrailer: String {
        if _movieTrailer == nil{
            return ""
        }
        
        return _movieTrailer!
    }
    
    var originalLanguage: String {
        if _originalLanguage == nil {
            return ""
        }
        
        return _originalLanguage!
    }
    
    var originalTitle: String {
        if _originalTitle == nil {
            return ""
        }
        
        return _originalTitle!
    }
    
    var overview: String {
        if _overview == nil {
            return ""
        }
        
        return _overview!
    }
    
    var popularity: Double {
        if _popularity == nil {
            return 0.0
        }
        
        return _popularity!
    }
    
    var posterPath: String {
        if _posterPath == nil {
            return ""
        }
        
        return _posterPath!
    }
    
    var releaseDate: String {
        if _releaseDate == nil {
            return ""
        }
        
        return _releaseDate!
    }
    
    var revenue: Int {
        if _revenue == nil {
            return 0
        }
        
        return _revenue!
    }
    
    var reviews: [Review] {
        if _reviews == nil {
            return []
        }
        
        return _reviews!
    }
    
    var runtime: Int {
        if _runtime == nil {
            return 0
        }
        
        return _runtime!
    }
    
    var status: String {
        if _status == nil {
            return ""
        }
        
        return _status!
    }
    
    var tagline: String {
        if _tagline == nil {
            return ""
        }
        
        return _tagline!
    }
    
    var title: String {
        if _title == nil {
            return ""
        }
        
        return _title!
    }
    
    var video: Bool {
        if _video == nil {
            return false;
        }
        
        return _video!
    }
    
    var voteAverage: Double {
        if _voteAverage == nil {
            return 0.0
        }
        
        return _voteAverage!
    }
    
    var voteCount: Int {
        if _voteCount == nil {
            return 0
        }
        
        return _voteCount!
    }
    
    
    init(dict: [String:Any]) {
        self.update(dict)
    }
    

    func update(_ dict: [String:Any]) {
        
        _adult = dict[movieKeys.Adult] as? Bool
        _backdropPath = dict[movieKeys.BackdropPath] as? String
        _budget = dict[movieKeys.Budget] as? String
        _cast = dict[movieKeys.Cast] as? [Cast]
        _character = dict[movieKeys.Character] as? String
        _genre = dict[movieKeys.Genres] as? [[String:Any]]
        _homepage = dict[movieKeys.Homepage] as? String
        _id = dict[movieKeys.ID] as? Int
        _imdbId = dict[movieKeys.IMDBID] as? String
        _movieTrailer = dict[movieKeys.MovieTrailer] as? String
        _originalLanguage = dict[movieKeys.OriginalLanguage] as? String
        _originalTitle = dict[movieKeys.OriginalTitle] as? String
        _overview = dict[movieKeys.Overview] as? String
        _popularity = dict[movieKeys.Popularity] as? Double
        _posterPath = dict[movieKeys.PosterPath] as? String
        _releaseDate = dict[movieKeys.ReleaseDate] as? String
        _revenue = dict[movieKeys.Revenue] as? Int
        _reviews = dict[movieKeys.Reviews] as? [Review]
        _runtime = dict[movieKeys.Runtime] as? Int
        _status = dict[movieKeys.Status] as? String
        _tagline = dict[movieKeys.Tagline] as? String
        _title = dict[movieKeys.Title] as? String
        _video = dict[movieKeys.Video] as? Bool
        _voteAverage = dict[movieKeys.VoteAverage] as? Double
        _voteCount = dict[movieKeys.VoteCount] as? Int
    }
    
    func runtimeToString() -> String? {
        
        if let runtime = _runtime {
            let minutes = runtime % 60;
            let hours = runtime / 60
            return "\(hours)hr \(minutes)min"
        }
        
        return nil
    }
    
    func imagePath(imagePath: DisplayType) -> String? {
        
        if imagePath == .poster {
            return posterPath
        } else if imagePath == .backdrop {
            return backdropPath
        } else if imagePath == .profile {
            return nil
        }
        
        return nil
    }
    
    
    
}

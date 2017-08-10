//
//  TV.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/1/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class TVShow {
    
    
    private var _backdropPath: String?
    private var _cast: [Cast]?
    private var _character: String?
    private var _createdBy: [[String:Any]]?
    private var _episodeRuntime: [Int]?
    private var _firstAirDate: String?
    private var _genres: [[String:Any]]?
    private var _homepage: String?
    private var _id: Int?
    private var _inProduction: Bool?
    private var _languages: [String]?
    private var _lastAirDate: String?
    private var _name: String?
    private var _networks: [TVNetwork]?
    private var _numOfEpisodes: Int?
    private var _numOfSeasons: Int?
    private var _overview: String?
    private var _popularity: Double?
    private var _posterPath: String?
    private var _seasons: [TVSeason]?
    private var _status: String?
    private var _type: String?
    private var _voteAverage: Double?
    private var _voteCount: Int?
    private var _video: String?
    
    var backdropPath: String {
        if _backdropPath == nil {
            return ""
        }
        
        return _backdropPath!
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
    
    var createdBy: [[String:Any]] {
        if _createdBy == nil {
            return []
        }
        
        return _createdBy!
    }
    
    var episodeRunTime: [Int] {
        if _episodeRuntime == nil {
            return []
        }
        
        return _episodeRuntime!
    }
    
    var firstAirDate: String {
        if _firstAirDate == nil {
            return ""
        }
        
        return _firstAirDate!
    }
    
    var genres: [[String:Any]] {
        if _genres == nil {
            return []
        }
        
        return _genres!
    }
    
    
    var homePage: String {
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
    
    var inProduction: Bool {
        if _inProduction == nil {
            return false
        }
        
        return _inProduction!
    }
    
    var languages: [String] {
        if _languages == nil {
            return []
        }
        
        return _languages!
    }
    
    var lastAirDate: String {
        if _lastAirDate == nil {
            return ""
        }
        
        return _lastAirDate!
    }
    
    
    var name: String {
        if _name == nil {
            return ""
        }
        
        return _name!
    }
    
    
    var networks: [TVNetwork] {
        if _networks == nil {
            return []
        }
        
        return _networks!
    }
    
    var numOfEpisodes: Int {
        if _numOfEpisodes == nil {
            return 0
        }
        
        return _numOfEpisodes!
    }
    
    
    var numOfSeason: Int {
        if _numOfSeasons == nil {
            return 0
        }
        
        return _numOfSeasons!
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
    
    
    var seasons: [TVSeason] {
        if _seasons == nil {
            return []
        }
        
        return _seasons!
    }
    
    
    var status: String {
        if _status == nil {
            return ""
        }
        
        return _status!
    }
    
    var type: String {
        if _type == nil {
             return ""
        }
        
        return _type!
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

    var video: String {
        if _video == nil {
            return ""
        }
        
        return _video!
    }
    
    func update(dict: [String:Any]) {
        
        _backdropPath = dict["backdrop_path"] as? String
        _cast = dict["cast"] as? [Cast]
        _createdBy = dict["created_by"] as? [[String:Any]]
        _character = dict["character"] as? String
        _episodeRuntime = dict["episode_run_time"] as? [Int]
        _firstAirDate = dict["first_air_date"] as? String
        _genres = dict["genres"] as? [[String:Any]]
        _homepage = dict["homepage"] as? String
        _id = dict["id"] as? Int
        _inProduction = dict["in_production"] as? Bool
        _languages = dict["languages"] as? [String]
        _lastAirDate = dict["last_air_date"] as? String
        _name = dict["name"] as? String
        _networks = dict["networks"] as? [TVNetwork]
        _numOfEpisodes = dict["number_of_episodes"] as? Int
        _numOfSeasons = dict["number_of_seasons"] as? Int
        _overview = dict["overview"] as? String
        _popularity = dict["popularity"] as? Double
        _posterPath = dict["poster_path"] as? String
        _seasons = dict["seasons"] as? [TVSeason]
        _status = dict["status"] as? String
        _type = dict["type"] as? String
        _voteAverage = dict["vote_average"] as? Double
        _voteCount = dict["vote_count"] as? Int
        _video = dict["videos"] as? String
    }
    
    
    init(dict: [String:Any]) {
        self.update(dict: dict)
    }
}







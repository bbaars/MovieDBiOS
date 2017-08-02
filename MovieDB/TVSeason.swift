//
//  TVSeason.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/1/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class TVSeason {
    
    
    private var _airDate: String?
    private var _episodeCount: Int?
    private var _id: Int?
    private var _posterPath: String?
    private var _seasonNumber: Int?
    
    var airDate: String {
        if _airDate == nil {
            return ""
        }
        
        return _airDate!
    }
    
    var episodeCount: Int {
        if _episodeCount == nil {
            return 0
        }
        
        return _episodeCount!
    }
    
    var id: Int {
        if _id == nil {
            return 0
        }
        
        return _id!
    }
    
    var posterPath: String {
        if _posterPath == nil {
            return ""
        }
        
        return _posterPath!
    }
    
    var seasonNumber: Int {
        if _seasonNumber == nil {
            return 0
        }
        
        return _seasonNumber!
    }
    
    
    
    init(dict: [String:Any]) {
        
        _airDate = dict["air_date"] as? String
        _episodeCount = dict["episode_count"] as? Int
        _id = dict["id"] as? Int
        _posterPath = dict["poster_path"] as? String
        _seasonNumber = dict["season_number"] as? Int
    }
    
    
    
}

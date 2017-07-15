//
//  Actor.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/10/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class Actor {
    
    private var _adult: Bool?
    private var _biography: String?
    private var _birthday: String?
    private var _deathday: String?
    private var _gender: Int?
    private var _homepage: String?
    private var _id: Int?
    private var _name: String?
    private var _placeOfBirth: String?
    private var _popularity: Double?
    private var _profilePath: String?
    
    var adult: Bool {
        
        if _adult == nil {
            return false
        }
        
        return _adult!
    }
    
    var biography: String {
        if _biography == nil {
            return ""
        }
        
        return _biography!
    }
    
    var birthday: String {
        if _birthday == nil {
            return ""
        }
        
        return _birthday!
    }
    
    var deathday: String {
        if _deathday == nil {
            return ""
        }
        
        return _deathday!
    }
    
    var gender: Int {
        if _gender == nil {
            return -1
        }
        
        return _gender!
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
    
    var name: String {
        if _name == nil {
            return ""
        }
        
        return _name!
    }
    
    var placeOfBirth: String {
        if _placeOfBirth == nil {
            return ""
        }
        
        return _placeOfBirth!
    }
    
    var popularity: Double {
        if _popularity == nil {
            return 0.0
        }
        
        return _popularity!
    }
    
    var profilePath: String {
        if _profilePath == nil {
            return ""
        }
        
        return _profilePath!
    }
    
    init(dict: [String:Any]) {
        self.update(dict)
    }
    
    
    func update(_ dict: [String:Any]) {
        _adult = dict[actorKeys.Adult] as? Bool
        _biography = dict[actorKeys.Biography] as? String
        _birthday = dict[actorKeys.Birthday] as? String
        _deathday = dict[actorKeys.Deathday] as? String
        _gender = dict[actorKeys.Gender] as? Int
        _homepage = dict[actorKeys.Homepage] as? String
        _id = dict[actorKeys.ID] as? Int
        _name = dict[actorKeys.Name] as? String
        _placeOfBirth = dict[actorKeys.PlaceOfBirth] as? String
        _popularity = dict[actorKeys.Popularity] as? Double
        _profilePath = dict[actorKeys.ProfilePath] as? String
    }
}

//
//  Cast.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/13/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class Cast {
    
    
    private var _character: String?
    private var _id: Int?
    private var _name: String?
    private var _profilePath: String?
    
    var character: String {
        if _character == nil {
            return ""
        }
        
        return _character!
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
    
    var profilePath: String {
        if _profilePath == nil {
            return ""
        }
        
        return _profilePath!
    }
    
    
    init(_ dict: [String:Any]) {
        update(dict)
    }
    
    func update(_ dict: [String:Any]) {
        _character = dict["character"] as? String
        _id = dict["id"] as? Int
        _name = dict["name"] as? String
        _profilePath = dict["profile_path"] as? String
    }
    
    
}

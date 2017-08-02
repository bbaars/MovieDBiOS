//
//  TVNetwork.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/1/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class TVNetwork {
    
    private var _id: Int?
    private var _name: String?
    
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
    
    init(dict: [String:Any]) {
        
        _id = dict["id"] as? Int
        _name = dict["name"] as? String
    }
}

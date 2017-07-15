//
//  Reviews.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/13/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation


class Review {
    
    private var _id: String?
    private var _author: String?
    private var _content: String?
    private var _url: String?
    
    var id: String {
        if _id == nil {
            return ""
        }
        
        return _id!
    }
    
    var author: String {
        if _author == nil {
            return ""
        }
        
        return _author!
    }
    
    var content: String {
        if _content == nil {
            return ""
        }
        
        return _content!
    }
    
    var url: String {
        if _url == nil {
            return ""
        }
        
        return _url!
    }
    
    
    init(dict: [String:Any]) {
        update(dict)
    }
    
    func update(_ dict: [String:Any]) {
        _id = dict[reviewKeys.ID] as? String
        _author = dict[reviewKeys.Author] as? String
        _content = dict[reviewKeys.Content] as? String
        _url = dict[reviewKeys.Url] as? String
    }
}

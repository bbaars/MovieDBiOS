//
//  MovieDB.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire

let APIKey = "6615c9824f812a6fb9b8b4ea5f49a285"
let APIUrlPrefix = "https://api.themoviedb.org/3"
let imageURLPrefix = "https://image.tmdb.org/t/p"

/*  Example Request
 https://api.themoviedb.org/3/discover/movie?with_people=287,819&sort_by=vote_average.desc&api_key=6615c9824f812a6fb9b8b4ea5f49a285
 */


class MovieDB {
    
    private var _url: String!
    
    fileprivate var parameters: Dictionary<String, AnyObject> = [
        "api_key": APIKey as AnyObject,
        "sort_by": "popularity.desc" as AnyObject
    ]
    
    init(url: String) {
        _url = url;
    }
    
    
    /* obtains the JSON Request for the provided URL */
    func downloadMovieDBDetails(completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
        Alamofire.request("\(APIUrlPrefix)/discover/movie?with_people=287,819&sort_by=vote_average.desc", parameters: ["api_key": APIKey]).responseJSON { response in
            
            print(response)
            
            if let dict = response.result.value as? [String:AnyObject] {
                
                print(dict)
                
            }
            
            completed()
        }
        
    }
    
    
    
}

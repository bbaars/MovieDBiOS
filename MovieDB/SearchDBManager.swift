//
//  SearchDBManager.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/30/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire


class SearchDBManager {
    
    var searchResults = [Any]()
    
    func getSearchResult() -> [Any] {
        return searchResults
    }
    
    
    func searchDatabase(query: String, completed: @escaping DownloadComplete) {
        
        
        Alamofire.request("\(APIUrlPrefix)/search/multi?api_key=\(APIKey)&language=en-US&query=\(query)&page=1&include_adult=false")
            
            .responseJSON { response in
                
                if let dict = response.result.value as? [String:Any] {
                    
                    if let results = dict["results"] as? [[String:Any]] {
                        
                        for result in results {
                            
                            if let mediaType = result["media_type"] as? String {
                                
                                if mediaType == "movie" {
                                    self.searchResults.append(Movie(dict: result))
                                } else if mediaType == "person" {
                                    self.searchResults.append(Actor(dict: result))
                                }
                            }
                        }
                    }
                }
            
                
            completed()
        }
    }
    
    func searchForMultipleActors(query: [String], completed: @escaping DownloadComplete) {
        
        var actors: String = ""
        
        for id in query {
            actors += id + ","
        }
        
        Alamofire.request("\(APIUrlPrefix)/discover/movie?with_people=\(actors)&sort_by=popularity.desc&api_key=\(APIKey)")
            
            .responseJSON { response in
                
                if let dict = response.result.value as? [String:Any] {
                    
                    if let results = dict["results"] as? [[String:Any]] {
                        
                        for movie in results {
                            self.searchResults.append(Movie(dict: movie))
                        }
                    }
                }
                completed()
            }
    }
}

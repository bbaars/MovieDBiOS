//
//  accountDBManager.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire


class AccountDBManager {
    
    var favMovies = [Movie]()
    var watchList = [Movie]()
    
    func getFavoriteMovies() -> [Movie] {
        return favMovies
    }
    
    func getWatchList() -> [Movie] {
        return watchList
    }
    
    
    func downloadFavoriteMovies(completed: @escaping DownloadComplete) {
        
        Alamofire.request("\(APIUrlPrefix)/account/%7Baccount_id%7D/favorite/movies?api_key=6615c9824f812a6fb9b8b4ea5f49a285&session_id=720e0b015cfd60b7ad5ab0f12f448f7b9acd35e6&language=en-US&sort_by=created_at.desc&page=1") .responseJSON { response in
            
            if let dict = response.result.value as? [String:Any] {
                
                if let results = dict["results"] as? [[String:Any]] {
                    
                    for movie in results {
                        
                        self.favMovies.append(Movie(dict: movie))
                    }
                }
            }
            completed()
        }
    }
    
    func downloadWatchList(completed: @escaping DownloadComplete) {
        
        Alamofire.request("\(APIUrlPrefix)/account/%7Baccount_id%7D/watchlist/movies?api_key=6615c9824f812a6fb9b8b4ea5f49a285&language=en-US&session_id=720e0b015cfd60b7ad5ab0f12f448f7b9acd35e6&sort_by=created_at.desc&page=1") .responseJSON { response in
            
            if let dict = response.result.value as? [String:Any] {
                
                if let results = dict["results"] as? [[String:Any]] {
                    
                    for movie in results {
                        self.watchList.append(Movie(dict: movie))
                    }
                }
            }
            completed()
        }
    }
    
    func addMovieToFavorites(id: Int, isFavorite: Bool, completed: @escaping DownloadComplete) {
        
        let json:[String:Any] = [
            "media_type": "movie",
            "media_id": id,
            "favorite": isFavorite
        ]
        
        Alamofire.request("\(APIUrlPrefix)/account/%7Baccount_id%7D/favorite?api_key=\(APIKey)&session_id=\(sessionString)", method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil)
            
            .responseJSON { response in
            
                completed()
        }
    }
    
    func addMovieToWatchList(id: Int, isWatchlist: Bool, completed: @escaping DownloadComplete) {
        
        let json:[String:Any] = [
            "media_type": "movie",
            "media_id": id,
            "watchlist": isWatchlist
        ]
        
        Alamofire.request("\(APIUrlPrefix)/account/%7Baccount_id%7D/watchlist?api_key=\(APIKey)&session_id=\(sessionString)", method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil)
            
            .responseJSON { response in
            
                completed()
        }
    }
}

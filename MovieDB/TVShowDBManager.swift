//
//  TVShowDBManager.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/1/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire

class TVShowDBManager {
    
    
    var tvShow: TVShow!
    var popularTVShows = [TVShow]()
    var count = 0
    
    func getTvShowDetails() -> TVShow {
        return tvShow
    }
    
    func getPopularTVShowDetails() -> [TVShow] {
        return popularTVShows
    }
    
    
    func downloadPopularTVShows(completed: @escaping DownloadComplete) {
        
        
        Alamofire.request("\(APIUrlPrefix)/tv/popular?api_key=\(APIKey)")
        
        .responseJSON { (results) in
            
            
            if let dict = results.result.value as? [String:Any] {
                
                if let results = dict["results"] as? [[String:Any]] {
                    
                    for tvshow in results {
                        
                        if let id = tvshow["id"] as? Int {
                            
                            self.downloadTVShowDBDetails(id: id, completed: { 
                                
                                self.count += 1
                                
                                if self.count == results.count {
                                    completed()
                                    print("Popular TV Shows Completed")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    func downloadTVShowDBDetails(id: Int, completed: @escaping DownloadComplete) {
        
        
        Alamofire.request("\(APIUrlPrefix)/tv/\(id)?api_key=\(APIKey)&append_to_response=credits,videos,reviews")
        
        .responseJSON { (results) in
            
            var tempDict = [String:Any]()
            
            if let show = results.result.value as? [String:Any] {
            
                //print(show)
                
                if let backdropPath = show["backdrop_path"] as? String {
                    tempDict["backdrop_path"] = backdropPath
                }
                
                if let createdBy = show["created_by"] as? [[String:Any]] {
                    var tempCreatedBy = [[String:Any]]()
                    
                    for person in createdBy {
                        
                        var tempPerson = [String:Any]()
                        
                        if let id = person["id"] as? Int {
                            tempPerson["id"] = id
                        }
                        
                        if let name = person["name"] as? Int {
                            tempPerson["name"] = name
                        }
                        
                        if let profilePath = person["profile_path"] as? String {
                            tempPerson["profile_path"] = profilePath
                        }
                        
                        tempCreatedBy.append(tempPerson)
                        tempPerson.removeAll()
                        
                    }
                    
                    tempDict["created_by"] = tempCreatedBy
                }
                
                if let episodeRunTime = show["episode_run_time"] as? [Int] {
                    tempDict["episode_run_time"] = episodeRunTime
                }
                
                if let firstAirDate = show["first_air_date"] as? String {
                    tempDict["first_air_date"] = firstAirDate
                }
                
                if let genres = show["genres"] as? [[String:Any]] {
                    var genreString = [[String:Any]]()
                    
                    for genre in genres {
                        
                        var tempGenres = [String:Any]()
                        
                        if let id = genre["id"] as? Int {
                            tempGenres["id"] = id
                        }
                        
                        if let name = genre["name"] as? String {
                            tempGenres["name"] = name
                        }
                        
                        genreString.append(tempGenres)
                        tempGenres.removeAll()
                    }
                    
                    tempDict["genres"] = genreString
                }
                
                
                if let homepage = show["homepage"] as? String {
                    tempDict["homepage"] = homepage
                }
                
                if let id = show["id"] as? Int {
                    tempDict["id"] = id
                }
                
                if let inProduction = show["in_production"] as? Bool {
                    tempDict["in_production"] = inProduction
                }
                
                if let languages = show["languages"] as? [String] {
                    tempDict["languages"] = languages
                }
                
                if let lastAirDate = show["last_air_date"] as? String {
                    tempDict["lastAirDate"] = lastAirDate
                }
                
                if let name = show["name"] as? String {
                    tempDict["name"] = name
                }
                
                if let numberOfEpisodes = show["number_of_episodes"] as? Int {
                    tempDict["number_of_episodes"] = numberOfEpisodes
                }
                
                if let numberOfSeasons = show["number_of_seasons"] as? Int {
                    tempDict["number_of_seasons"] = numberOfSeasons
                }
                
                if let overview = show["overview"] as? String {
                    tempDict["overview"] = overview
                }
                
                if let popularity = show["popularity"] as? Double {
                    tempDict["popularity"] = popularity
                }
                
                if let posterPath = show["poster_path"] as? String {
                    tempDict["poster_path"] = posterPath
                }
                
                if let seasons = show["seasons"] as? [[String:Any]] {
                    
                    var tempSeasons = [TVSeason]()
                    
                    for season in seasons {
                        tempSeasons.append(TVSeason(dict: season))
                    }
                    
                    tempDict["seasons"] = tempSeasons
                }
                
                if let status = show["status"] as? String {
                    tempDict["status"] = status
                }
                
                if let type = show["type"] as? String {
                    tempDict["type"] = type
                }
                
                if let voteAvg = show["vote_average"] as? Double {
                    tempDict["vote_average"] = voteAvg
                }
                
                if let voteCount = show["vote_count"] as? Int {
                    tempDict["vote_count"] = voteCount
                }
                
                if let credits = show["credits"] as? [String:Any] {
                    
                    if let cast = credits["cast"] as? [[String:Any]] {
                        
                        var tempCast = [Cast]()
                        
                        for person in cast {
                            tempCast.append(Cast(dict: person))
                        }
                        
                        tempDict["cast"] = tempCast
                    }
                }
                
                if let videos = show["videos"] as? [String:Any] {
                    if let results = videos["results"] as? [[String:Any]] {
                        if results.count > 0 {
                            if let key = results[0]["key"] as? String {
                                tempDict["videos"] = key
                            }
                        }
                    }
                }
                
            }
            
            self.tvShow = TVShow(dict: tempDict)
            self.popularTVShows.append(TVShow(dict: tempDict))
            tempDict.removeAll()
            completed()
        }
    }
    
}
































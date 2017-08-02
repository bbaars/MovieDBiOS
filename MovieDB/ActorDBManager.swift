//
//  ActorDBManager.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/12/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire

/*
 https://api.themoviedb.org/3/person/500?api_key=6615c9824f812a6fb9b8b4ea5f49a285&language=en-US&append_to_response=movie_credits
 */

class ActorDBManager {
    
    var moviesOfActor = [Movie]()
    var actor: Actor!
    var topActors = [Actor]()
    
    func getActor() -> Actor {
        return actor
    }
    
    func getActors() -> [Actor] {
        return topActors
    }
    
    /* obtains the JSON Request for the provided URL.
     @param parameter: A Struct of keywords that can search for different things in the API */
    func downloadActorDetails(actorID: String, completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
        Alamofire.request("\(APIUrlPrefix)/person/\(actorID)?api_key=\(APIKey)&append_to_response=combined_credits")
            
            .downloadProgress { progress in
                
//                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                
                /* Obtains the dictionary representation of the JSON */
                if let dict = response.result.value as? [String:Any] {
                    
                    if let results = dict["results"] as? [[String:Any]] {
                        
                        for actor in results {
                            self.parseJSON(dict: actor)
                        }
                        
                    } else {
                        self.parseJSON(dict: dict)
                    }

                }
                
            completed()
        }        
    }
    
    
    func parseJSON(dict: [String:Any]) {
        
        var tempDict = [String:Any]()
        
        if let name = dict[actorKeys.Name] as? String {
            tempDict[actorKeys.Name] = name;
        }
        
        if let deathday = dict[actorKeys.Deathday] as? String {
            tempDict[actorKeys.Deathday] = deathday;
        }
        
        if let birthday = dict[actorKeys.Birthday] as? String {
            tempDict[actorKeys.Birthday] = birthday
        }
        
        if let id = dict[actorKeys.ID] as? Int {
            tempDict[actorKeys.ID] = id
        }
        
        if let name = dict[actorKeys.Name] as? String {
            tempDict[actorKeys.Name] = name
        }
        
        
        if let movieCredits = dict["combined_credits"] as? [String:Any] {
            
            if let castMovies = movieCredits["cast"] as? [[String:Any]] {
                
                var tempMovies = [Movie]()
                var tempShows = [TVShow]()
                
                for cast in castMovies {
                   
                    if let mediaType = cast["media_type"] as? String {
                        
                        if mediaType == "movie" {
                            tempMovies.append(Movie(dict: cast))
                        } else if mediaType == "tv" {
                            tempShows.append(TVShow(dict: cast))
                        }
                    }
                }
                
                tempDict[actorKeys.TVShows] = tempShows
                tempDict[actorKeys.Movies] = tempMovies
            }
        }
        
        if let homepage = dict[actorKeys.Homepage] as? String {
            tempDict[actorKeys.Homepage] = homepage
        }
        
        if let biography = dict[actorKeys.Biography] as? String {
            tempDict[actorKeys.Biography] = biography
        }
        
        if let placeOfBirth = dict[actorKeys.PlaceOfBirth] as? String {
            tempDict[actorKeys.PlaceOfBirth] = placeOfBirth
        }
        
        if let adult = dict[actorKeys.Adult] as? Bool {
            tempDict[actorKeys.Adult] = adult
        }
        
        if let profilePath = dict[actorKeys.ProfilePath] as? String {
            tempDict[actorKeys.ProfilePath] = profilePath
        }
        
        if let gender = dict[actorKeys.Gender] as? Int {
            tempDict[actorKeys.Gender] = gender
        }
        
        if let popularity = dict[actorKeys.Popularity] as? Double {
            tempDict[actorKeys.Popularity] = popularity
        }
        
        self.topActors.append(Actor(dict: tempDict))
        self.actor = Actor(dict: tempDict)
    }
}

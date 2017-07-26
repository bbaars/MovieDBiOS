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
    
    func getActor() -> Actor {
        return actor
    }
    
    /* obtains the JSON Request for the provided URL.
     @param parameter: A Struct of keywords that can search for different things in the API */
    func downloadActorDetails(actorID: String, completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
        Alamofire.request("\(APIUrlPrefix)/person/\(actorID)?api_key=\(APIKey)&Append_to_response=movie_credits")
            
            .downloadProgress { progress in
                
//                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                
                var tempDict = [String:Any]()
                
                /* Obtains the dictionary representation of the JSON */
                if let dict = response.result.value as? [String:Any] {
                    
                    if let name = dict[actorKeys.Name] as? String {
                        tempDict[actorKeys.Name] = name;
                    }
                    
                    if let deathday = dict[actorKeys.Deathday] as? String {
                        tempDict[actorKeys.Deathday] = deathday;
                    }
                    
                    if let id = dict[actorKeys.ID] as? Int {
                        tempDict[actorKeys.ID] = id
                    }
                    
                    if let name = dict[actorKeys.Name] as? String {
                        tempDict[actorKeys.Name] = name
                    }
                    
                    if let movieCredits = dict["movie_credits"] as? [String:Any] {
                        
                        if let castMovies = movieCredits["cast"] as? [[String:Any]] {
                            
                            var tempMovies = [Movie]()
                            
                            for movie in castMovies {
                                tempMovies.append(Movie(dict: movie))
                            }

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
                    
                    self.actor = Actor(dict: tempDict)

                }
                
            completed()
        }        
    }
}

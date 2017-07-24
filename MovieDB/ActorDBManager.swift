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
    
    
    /* obtains the JSON Request for the provided URL.
     @param parameter: A Struct of keywords that can search for different things in the API */
    func downloadActorDetails(actorID: String, completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
        Alamofire.request("\(APIUrlPrefix)/person/\(actorID)?api_key=\(APIKey)&Append_to_response=movie_credits")
            
            .downloadProgress { progress in
                
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON {response in
                
                var tempDict = [String:Any]()
                
                /* Obtains the dictionary representation of the JSON */
                if let dict = response.result.value as? [String:Any] {
                    
                    print(dict)
                    
                    if let name = dict[actorKeys.Name] as? String {
                        tempDict[actorKeys.Name] = name;
                    }
                    
                    
                }
        }
        
        completed()
    }
}

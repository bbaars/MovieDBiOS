//
//  MovieDB.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


/*  Example Movie Request
 https://api.themoviedb.org/3/discover/movie?with_people=287,819&sort_by=vote_average.desc&api_key=6615c9824f812a6fb9b8b4ea5f49a285
 */

/*  Example Image Request
 let url = URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!
 image.af_setImage(withURL: url)
 */


class MovieDBManager {
    
    var topMovies = [Movie]()
    var detailedTopMovies = [Movie]()
    var moviePoster = [String:URL]()
    var count = 0
    
    /* parameter that could be entered in the API Request */
    fileprivate var parameters: Dictionary<String, Any> = [
        "api_key": APIKey as Any,
        ]
    
    
    init() {
        
    }
    
    func getTopMovies() -> [Movie] {
        return topMovies
    }
    
    func getMovieDetails() -> [Movie] {
        return detailedTopMovies
    }
    
    
    /* obtains the JSON Request for the provided URL.
     @param parameter: A Struct of keywords that can search for different things in the API */
    func downloadMovieDBDetails(parameter: String, completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
        Alamofire.request("\(APIUrlPrefix)\(parameter)?", parameters: ["api_key": APIKey]).responseJSON { response in
            
            // print(response)
            
            /* Obtains the dictionary representation of the JSON */
            if let dict = response.result.value as? [String:Any] {
                
                
                /* part of the JSON data is 'results' which is an array of dictionaries */
                if let results = dict["results"] as? [[String:Any]] {
                    
                    
                    /* temporary dictory for us to later add to our array of movies */
                    var tempDict = [String:Any]()
                    
                    /* loop through every received movie in results */
                    for movie in results {
                        
                        if let id = movie[movieKeys.ID] {
                            self.downloadMoreMovieDetails(url: "\(APIUrlPrefix)/movie/\(id)?api_key=") {
                                self.count += 1
                                
                                if self.count == results.count {
                                    completed()
                                     print("Completed")
                                }
                            }
                        }
                        
                        /* if these  optional values exist, we can set them */
                        if let adult = movie[movieKeys.Adult] as? Bool {
                            tempDict[movieKeys.Adult] = adult
                        }
                        
                        if let backdropPath = movie[movieKeys.BackdropPath] as? String {
                            tempDict[movieKeys.BackdropPath] = backdropPath
                        }
 
                        if let id = movie[movieKeys.ID] as? Int {
                            tempDict[movieKeys.ID] = id
                        }
                        
                        if let imdbId = movie[movieKeys.IMDBID] as? String {
                            tempDict[movieKeys.IMDBID] = imdbId
                        }
                        
                        if let originalLang = movie[movieKeys.OriginalLanguage] as? String {
                            tempDict[movieKeys.OriginalLanguage] = originalLang
                        }
                        
                        if let originalTitle = movie[movieKeys.OriginalTitle] as? String {
                            tempDict[movieKeys.OriginalTitle] = originalTitle
                        }
                        
                        if let overview = movie[movieKeys.Overview] as? String {
                            tempDict[movieKeys.Overview] = overview
                        }
                        
                        if let popularity = movie[movieKeys.Popularity] as? Double {
                            tempDict[movieKeys.Popularity] = popularity
                        }
                        
                        if let posterPath = movie[movieKeys.PosterPath] as? String {
                            tempDict[movieKeys.PosterPath] = posterPath
                        }
                        
                        if let releaseDate = movie[movieKeys.ReleaseDate] as? String {
                            tempDict[movieKeys.ReleaseDate] = releaseDate
                        }

                        if let status = movie[movieKeys.Status] as? String {
                            tempDict[movieKeys.Status] = status
                        }
                        
                        if let title = movie[movieKeys.Title] as? String {
                            tempDict[movieKeys.Title] = title
                        }
                        
                        if let video =  movie[movieKeys.Video] as? Bool {
                            tempDict[movieKeys.Video] = video
                        }
                        
                        if let voteAvg = movie[movieKeys.VoteAverage] as? Double {
                            tempDict[movieKeys.VoteAverage] = voteAvg
                        }
                        
                        if let voteCount = movie[movieKeys.VoteCount] as? Int {
                            tempDict[movieKeys.VoteCount] = voteCount
                        }
                        
                        self.topMovies.append(Movie(dict: tempDict))
                        tempDict.removeAll()
                    }
                }
            }
        }
    }
    

    
    /* obtain even more information about the movies based on their ID */
    private func downloadMoreMovieDetails(url: String, completed: @escaping DownloadComplete) {
        
        
        Alamofire.request("\(url)\(APIKey)&append_to_response=videos").responseJSON { response in
            
            /* Obtains the dictionary representation of the JSON */
            if let movie = response.result.value as? [String:Any] {
                
                /* temporary dictory for us to later add to our array of movies */
                var tempDict = [String:Any]()
                
                /* if these  optional values exist, we can set them */
                if let adult = movie[movieKeys.Adult] as? Bool {
                    tempDict[movieKeys.Adult] = adult
                }
                
                if let backdropPath = movie[movieKeys.BackdropPath] as? String {
                    tempDict[movieKeys.BackdropPath] = backdropPath
                }
                
                if let budget = movie[movieKeys.Budget] as? String {
                    tempDict[movieKeys.Budget] = budget
                }
                
                if let homepage = movie[movieKeys.Homepage] as? String {
                    tempDict[movieKeys.Homepage] = homepage
                }
                
                if let id = movie[movieKeys.ID] as? Int {
                    tempDict[movieKeys.ID] = id
                }
                
                if let imdbId = movie[movieKeys.IMDBID] as? String {
                    tempDict[movieKeys.IMDBID] = imdbId
                }
                
                if let originalLang = movie[movieKeys.OriginalLanguage] as? String {
                    tempDict[movieKeys.OriginalLanguage] = originalLang
                }
                
                if let originalTitle = movie[movieKeys.OriginalTitle] as? String {
                    tempDict[movieKeys.OriginalTitle] = originalTitle
                }
                
                if let overview = movie[movieKeys.Overview] as? String {
                    tempDict[movieKeys.Overview] = overview
                }
                
                if let popularity = movie[movieKeys.Popularity] as? Double {
                    tempDict[movieKeys.Popularity] = popularity
                }
                
                if let posterPath = movie[movieKeys.PosterPath] as? String {
                    tempDict[movieKeys.PosterPath] = posterPath
                }
                
                if let releaseDate = movie[movieKeys.ReleaseDate] as? String {
                    tempDict[movieKeys.ReleaseDate] = releaseDate
                }
                
                if let revenue =  movie[movieKeys.Revenue] as? Int {
                    tempDict[movieKeys.Revenue] = revenue
                }
                
                if let runtime = movie[movieKeys.Runtime] as? Int {
                    tempDict[movieKeys.Runtime] = runtime
                }
                
                if let status = movie[movieKeys.Status] as? String {
                    tempDict[movieKeys.Status] = status
                }
                
                if let tagline = movie[movieKeys.Tagline] as? String {
                    tempDict[movieKeys.Tagline] = tagline
                }
                
                if let title = movie[movieKeys.Title] as? String {
                    tempDict[movieKeys.Title] = title
                }
                
                if let video =  movie[movieKeys.Video] as? Bool {
                    tempDict[movieKeys.Video] = video
                }
                
                if let voteAvg = movie[movieKeys.VoteAverage] as? Double {
                    tempDict[movieKeys.VoteAverage] = voteAvg
                }
                
                if let voteCount = movie[movieKeys.VoteCount] as? Int {
                    tempDict[movieKeys.VoteCount] = voteCount
                }
                
                if let videos = movie["videos"] as? [String:Any] {
                    if let results = videos["results"] as? [[String:Any]] {
                        if let key = results[0]["key"] as? String {
                            tempDict[movieKeys.MovieTrailer] = key

                        }
                    }
                }
                
                self.detailedTopMovies.append(Movie(dict: tempDict))
                tempDict.removeAll()
            }
        
            completed()
        }
    }
}































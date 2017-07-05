//
//  MovieDB.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import Alamofire


class MovieDB {
    
    private var _url: String
    
    init(url: String) {
        self._url = url;
    }
    
    func downloadMovieDBDetails(completed: @escaping DownloadComplete) {
        
        /* alamo fire request */
    }
    
    
    
}

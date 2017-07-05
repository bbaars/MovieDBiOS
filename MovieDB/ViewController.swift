//
//  ViewController.swift
//  MovieDB
//
//  Created by Brandon Baars on 6/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var movie = MovieDB(url: "discover/movie?sort_by=popularity.desc")
        movie.downloadMovieDBDetails {
            
            print("completed")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

